import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';

abstract class BookingDataSource {
  Future<void> createBooking(Booking booking);
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
}
