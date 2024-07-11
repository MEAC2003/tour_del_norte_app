import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/data/models/payment.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _bookingRepository;
  final SupabaseClient _supabase = Supabase.instance.client;

  BookingProvider(this._bookingRepository);
  List<Booking> _userBookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get userBookings => _userBookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Aquí deberías implementar la lógica para obtener las reservas del usuario
      // Por ejemplo, usando Supabase o algún otro servicio
      _userBookings = await _bookingRepository.getUserBookings();
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

  Future<void> createPaymentForBooking(int bookingId, double amount) async {
    try {
      final payment = Payment(
        bookingId: bookingId,
        status: 'pendiente',
        paymentDeadline: DateTime.now().add(const Duration(hours: 24)),
        amount: amount,
      );

      final paymentMap = payment.toJson();
      // Removemos los campos que no queremos insertar
      paymentMap.remove('id');
      paymentMap.remove('created_at');
      print('Inserting payment: $paymentMap'); // Para depuración

      final paymentResponse = await _supabase
          .from('payment') // Nota: cambiado de 'payments' a 'payment'
          .insert(paymentMap)
          .select()
          .single();
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
      await _supabase.from('payment').update({
        'status': 'cancelado',
        'cancelled_at': DateTime.now().toIso8601String(),
      }).eq('booking_id', bookingId);

      notifyListeners();
    } catch (e) {
      print('Error cancelling booking: $e');
      throw Exception('Error cancelling booking: $e');
    }
  }

  Future<void> confirmPayment(int bookingId) async {
    try {
      await _supabase.from('payment').update({
        'status': 'pagado',
        'paid_at': DateTime.now().toIso8601String(),
      }).eq('booking_id', bookingId);

      notifyListeners();
    } catch (e) {
      print('Error confirming payment: $e');
      throw Exception('Error confirming payment: $e');
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
}
