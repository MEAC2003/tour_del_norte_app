import 'package:tour_del_norte_app/features/home/data/models/booking.dart';

abstract class BookingRepository {
  Future<void> createBooking(Booking booking);
  Future<List<Booking>> getUserBookings(); // Añade este método
  Future<List<Booking>> getAllBookings(); // Añade este método
}