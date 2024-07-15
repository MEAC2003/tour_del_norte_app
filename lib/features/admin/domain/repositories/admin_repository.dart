import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_brand.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/admin/data/models/payment.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';

abstract class AdminRepository {
  Future<List<Booking>> getRecentBookings(int limit);
  Future<int> getTodayBookingsCount();
  Future<int> getAvailableCarsCount();
  Future<List<Car>> getAllCars();
  Future<double> getTotalRevenue();
  Future<List<PublicUser>> getAllUsers();
  Future<void> updateUser(PublicUser user);
  Future<Map<String, dynamic>> addPendingUser(PublicUser user);
  Future<void> addCar(Car car);
  Future<List<CarType>> getAllCarTypes();
  Future<List<CarBrand>> getAllCarBrands();
  Future<void> updateCar(Car car);
  Future<void> deleteCar(int carId);
  Future<List<Booking>> getBookingsForCar(int carId);
  Future<void> deleteUser(String userId);
  Future<List<Booking>> getBookingsForUser(String userId);
  Future<Payment?> getPaymentForBooking(int bookingId);
}
