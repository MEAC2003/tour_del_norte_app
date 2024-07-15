import 'package:tour_del_norte_app/features/home/data/datasources/supabase_booking_data_source.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDataSource _bookingDataSource;

  BookingRepositoryImpl(this._bookingDataSource);

  @override
  Future<void> createBooking(Booking booking) async {
    await _bookingDataSource.createBooking(booking);
  }

  @override
  Future<List<Booking>> getUserBookings() async {
    return await _bookingDataSource.getUserBookings();
  }

  @override
  Future<List<Booking>> getAllBookings() async {
    try {
      return await _bookingDataSource.getAllBookings();
    } catch (e) {
      print('Error en getAllBookings en Repository: $e');
      rethrow;
    }
  }
}
