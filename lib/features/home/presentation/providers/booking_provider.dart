import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/data/models/payment.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _bookingRepository;
  final SupabaseClient _supabase = Supabase.instance.client;

  BookingProvider(this._bookingRepository);
  List<Booking> _userBookings = [];
  List<Booking> _filteredBookings = [];
  List<BookingWithDetails> _allBookingsWithDetails = [];
  List<BookingWithDetails> _filteredBookingsWithDetails = [];
  String _searchQuery = '';
  final Set<String> _selectedStatuses = {};
  Set<String> get selectedStatuses => _selectedStatuses;
  bool _isLoading = false;
  String? _error;
  List<Booking> get userBookings =>
      _filteredBookings.isEmpty ? _userBookings : _filteredBookings;
  List<BookingWithDetails> get bookingsWithDetails =>
      _filteredBookingsWithDetails.isEmpty
          ? _allBookingsWithDetails
          : _filteredBookingsWithDetails;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Future<void> fetchAllBookingsWithDetails() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allBookingsWithDetails = await getBookingsWithDetails();
      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Aquí deberías implementar la lógica para obtener las reservas del usuario
      // Por ejemplo, usando Supabase o algún otro servicio
      _userBookings = await _bookingRepository.getUserBookings();
      _filteredBookings = [];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createBooking(Booking booking) async {
    try {
      // Crear la reserva
      final bookingMap = booking.toJson()..remove('id');
      print('Inserting booking: $bookingMap'); // Para depuración
      final response =
          await _supabase.from('bookings').insert(bookingMap).select().single();
      print('Booking response: $response'); // Para depuración

      final newBookingId = response['id'];

      // Crear el pago asociado a esta reserva
      await createPaymentForBooking(newBookingId, booking.total.toDouble());
      await fetchAllBookingsWithDetails();
      notifyListeners();
    } catch (e) {
      print('Error creating booking: $e');
      if (e is PostgrestException) {
        print('PostgrestException details: ${e.details}');
        print('PostgrestException hint: ${e.hint}');
      }
      throw Exception('Error creating booking: $e');
    }
  }

  Future<bool> canChangeStatus(int bookingId, String newStatus) async {
    final payment = await getPaymentForBooking(bookingId);

    if (payment == null) return false;

    switch (newStatus) {
      case 'pagado':
        return payment.status == 'pendiente';
      case 'cancelado':
        return payment.status == 'pendiente';
      case 'completado':
        return payment.status == 'pagado';
      default:
        return false;
    }
  }

  Future<void> createPaymentForBooking(int bookingId, double amount) async {
    try {
      final payment = Payment(
        bookingId: bookingId,
        status: 'pendiente',
        paymentDeadline: DateTime.now().add(const Duration(minutes: 10)),
        amount: amount,
      );

      final paymentMap = payment.toJson();
      // Removemos los campos que no queremos insertar
      paymentMap.remove('id');
      paymentMap.remove('created_at');
      print('Inserting payment: $paymentMap'); // Para depuración

      final paymentResponse =
          await _supabase.from('payment').insert(paymentMap).select().single();
      print('Payment response: $paymentResponse'); // Para depuración
    } catch (e) {
      print('Error creating payment: $e');
      if (e is PostgrestException) {
        print('PostgrestException code: ${e.code}');
        print('PostgrestException message: ${e.message}');
        print('PostgrestException details: ${e.details}');
        print('PostgrestException hint: ${e.hint}');
      }
      rethrow;
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    try {
      if (await canChangeStatus(bookingId, 'cancelado')) {
        await _supabase.from('payment').update({
          'status': 'cancelado',
          'cancelled_at': DateTime.now().toIso8601String(),
          'paid_at': null, // Limpiar el campo de pago si existía
          'completed': null, // Limpiar el campo de completado si existía
        }).eq('booking_id', bookingId);
        await fetchAllBookingsWithDetails();
        notifyListeners();
      } else {
        throw Exception(
            'No se puede cancelar esta reserva en su estado actual.');
      }
    } catch (e) {
      print('Error cancelling booking: $e');
      throw Exception('Error cancelling booking: $e');
    }
  }

  Future<void> confirmPayment(int bookingId) async {
    try {
      if (await canChangeStatus(bookingId, 'pagado')) {
        await _supabase.from('payment').update({
          'status': 'pagado',
          'paid_at': DateTime.now().toIso8601String(),
          'cancelled_at': null, // Limpiar el campo de cancelación si existía
        }).eq('booking_id', bookingId);
        await fetchAllBookingsWithDetails();
        notifyListeners();
      } else {
        throw Exception(
            'No se puede confirmar el pago de esta reserva en su estado actual.');
      }
    } catch (e) {
      print('Error confirming payment: $e');
      throw Exception('Error confirming payment: $e');
    }
  }

  Future<void> completeBooking(int bookingId) async {
    print('Iniciando completeBooking para bookingId: $bookingId');
    try {
      if (await canChangeStatus(bookingId, 'completado')) {
        final result = await _supabase
            .from('payment')
            .update({
              'status': 'completado',
              'completed': DateTime.now().toIso8601String(),
              'cancelled_at': null, // Asegurar que no haya fecha de cancelación
            })
            .eq('booking_id', bookingId)
            .select();

        print('Resultado de la actualización: $result');

        if ((result.isEmpty)) {
          throw Exception('La actualización no afectó a ningún registro.');
        }

        await fetchAllBookingsWithDetails(); // Refresh the list
        print('Lista de reservas actualizada');
      } else {
        throw Exception(
            'No se puede completar esta reserva en su estado actual.');
      }
    } catch (e) {
      print('Error detallado en completeBooking: $e');
      if (e is PostgrestException) {
        print('Código PostgrestException: ${e.code}');
        print('Mensaje PostgrestException: ${e.message}');
        print('Detalles PostgrestException: ${e.details}');
      }
      throw Exception('Error completing booking: $e');
    }
  }

  Future<Payment?> getPaymentForBooking(int bookingId) async {
    try {
      final paymentResponse = await _supabase
          .from('payment')
          .select()
          .eq('booking_id', bookingId)
          .single();
      return Payment.fromJson(paymentResponse);
    } catch (e) {
      print('Error getting payment for booking $bookingId: $e');
      return null;
    }
  }

  Future<List<Booking>> getBookingsForCar(int carId) async {
    try {
      final response =
          await _supabase.from('bookings').select().eq('id_car', carId);
      return (response as List)
          .map((booking) => Booking.fromJson(booking))
          .toList();
    } catch (e) {
      print('Error getting bookings for car: $e');
      throw Exception('Error getting bookings for car: $e');
    }
  }

  Future<List<BookingWithDetails>> getBookingsWithDetails() async {
    print('Iniciando getBookingsWithDetails');
    try {
      final bookings =
          await getAllBookings(); // Esto ya devolverá las reservas ordenadas
      print('Número de reservas obtenidas: ${bookings.length}');

      final bookingsWithDetails = await Future.wait(
        bookings.map((booking) async {
          print('Procesando reserva con ID: ${booking.id}');
          final paymentFuture = getPaymentForBooking(booking.id!);
          final carFuture = getCarDetails(booking.idCar);

          final [payment, car] = await Future.wait([paymentFuture, carFuture]);

          return BookingWithDetails(
            booking: booking,
            payment: payment as Payment,
            car: car as Car,
          );
        }),
      );

      print('Número de reservas con detalles: ${bookingsWithDetails.length}');
      return bookingsWithDetails;
    } catch (e) {
      print('Error en getBookingsWithDetails: $e');
      if (e is PostgrestException) {
        print('PostgrestException detalles: ${e.details}');
        print('PostgrestException hint: ${e.hint}');
      }
      rethrow;
    }
  }

  Future<List<Booking>> getAllBookings() async {
    print('Iniciando getAllBookings');
    try {
      final response = await _supabase
          .from('bookings')
          .select()
          .order('created_at', ascending: false); // Añade esta línea
      print('Respuesta de Supabase: $response');
      final bookings =
          (response as List).map((data) => Booking.fromJson(data)).toList();
      print('Número de reservas obtenidas: ${bookings.length}');
      return bookings;
    } catch (e) {
      print('Error en getAllBookings: $e');
      rethrow;
    }
  }

  Future<Car> getCarDetails(int carId) async {
    try {
      final response =
          await _supabase.from('car').select().eq('id', carId).single();
      return Car.fromJson(response);
    } catch (e) {
      print('Error getting car details: $e');
      rethrow;
    }
  }

  void searchBookings(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void toggleStatusFilter(String status) {
    if (_selectedStatuses.contains(status)) {
      _selectedStatuses.remove(status);
    } else {
      _selectedStatuses.add(status);
    }
    _applyFilters();
  }

  void _applyFilters() {
    _filteredBookingsWithDetails =
        _allBookingsWithDetails.where((bookingWithDetails) {
      // Aplicar filtro de búsqueda por texto
      bool matchesSearch = _searchQuery.isEmpty ||
          bookingWithDetails.booking.fullName
              .toLowerCase()
              .contains(_searchQuery) ||
          bookingWithDetails.booking.email.toLowerCase().contains(_searchQuery);

      // Aplicar filtro por estado
      bool matchesStatus = _selectedStatuses.isEmpty ||
          _selectedStatuses.contains(bookingWithDetails.status.toLowerCase());

      return matchesSearch && matchesStatus;
    }).toList();

    notifyListeners();
  }

  Future<void> deleteBooking(int bookingId) async {
    try {
      await _supabase.from('payment').delete().eq('booking_id', bookingId);
      await _supabase.from('bookings').delete().eq('id', bookingId);
      await fetchAllBookingsWithDetails(); // Actualiza la lista de reservas
      notifyListeners(); // Notifica a los listeners
    } catch (e) {
      print('Error deleting booking: $e');
      throw Exception('Error deleting booking: $e');
    }
  }
}

class BookingWithDetails {
  final Booking booking;
  final Payment? payment;
  final Car car;

  BookingWithDetails({
    required this.booking,
    this.payment,
    required this.car,
  });
  String get status => payment?.status ?? 'desconocido';
}
