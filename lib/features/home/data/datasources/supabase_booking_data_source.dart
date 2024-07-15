import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';

abstract class BookingDataSource {
  Future<void> createBooking(Booking booking);
  Future<List<Booking>> getUserBookings();
  Future<List<Booking>> getAllBookings();
}

class SupabaseBookingDataSourceImpl implements BookingDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<void> createBooking(Booking booking) async {
    try {
      await _supabase.from('bookings').insert(booking.toJson());
    } catch (e) {
      throw Exception('Error creating booking: $e');
    }
  }

  @override
  Future<List<Booking>> getUserBookings() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final response = await _supabase
          .from('bookings')
          .select()
          .eq('id_user', user.id)
          .order('created_at', ascending: false);

      return response.map((json) => Booking.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching user bookings: $e');
    }
  }

  @override
  Future<List<Booking>> getAllBookings() async {
    try {
      final response = await _supabase.from('bookings').select();
      print('Respuesta de getAllBookings en DataSource: $response');
      return (response as List).map((data) => Booking.fromJson(data)).toList();
    } catch (e) {
      print('Error en getAllBookings en DataSource: $e');
      throw Exception('Failed to get bookings: $e');
    }
  }
}
