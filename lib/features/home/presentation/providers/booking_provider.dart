import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _bookingRepository;
  final SupabaseClient _supabase = Supabase.instance.client;
  BookingProvider(this._bookingRepository);

  Future<void> createBooking(Booking booking) async {
    try {
      // Removemos el id del mapa si existe
      final bookingMap = booking.toJson()..remove('id');

      final response =
          await _supabase.from('bookings').insert(bookingMap).select().single();

      // La respuesta ahora contiene directamente los datos insertados
      print('Booking created: $response');

      // Si necesita el ID generado, puede acceder a él así:
      // final newBookingId = response['id'];

      notifyListeners();
    } catch (e) {
      print('Error creating booking: $e');
      throw Exception('Error creating booking: $e');
    }
  }
}
