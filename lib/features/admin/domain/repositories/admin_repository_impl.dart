import 'package:tour_del_norte_app/features/admin/data/datasources/supabase_admin_data_source.dart';
import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_brand.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/admin/data/models/payment.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final SupabaseAdminDataSource _dataSource;

  AdminRepositoryImpl(this._dataSource);

  @override
  Future<List<Booking>> getRecentBookings(int limit) async {
    return await _dataSource.getRecentBookings(limit);
  }

  @override
  Future<int> getTodayBookingsCount() async {
    return await _dataSource.getTodayBookingsCount();
  }

  @override
  Future<int> getAvailableCarsCount() async {
    return await _dataSource.getAvailableCarsCount();
  }

  @override
  Future<double> getTotalRevenue() async {
    return await _dataSource.getTotalRevenue();
  }

  @override
  Future<List<Car>> getAllCars() async {
    return await _dataSource.getAllCars(); // Añade este método
  }

  // Nuevos métodos implementados
  @override
  Future<List<PublicUser>> getAllUsers() async {
    return await _dataSource.getAllUsers();
  }

  @override
  Future<void> updateCar(Car car) async {
    await _dataSource.updateCar(car);
  }

  @override
  Future<void> deleteCar(int carId) async {
    await _dataSource.deleteCar(carId);
  }

  @override
  Future<void> updateUser(PublicUser user) async {
    await _dataSource.updateUser(user);
  }

  @override
  Future<Map<String, dynamic>> addPendingUser(PublicUser user) async {
    return await _dataSource.addPendingUser(user);
  }

  @override
  Future<void> addCar(Car car) async {
    await _dataSource.addCar(car);
  }

  @override
  Future<List<CarType>> getAllCarTypes() async {
    return await _dataSource.getAllCarTypes();
  }

  @override
  Future<Payment?> getPaymentForBooking(int bookingId) async {
    return await _dataSource.getPaymentForBooking(bookingId);
  }

  @override
  Future<List<CarBrand>> getAllCarBrands() async {
    return await _dataSource.getAllCarBrands();
  }

  @override
  Future<List<Booking>> getBookingsForUser(String userId) async {
    print('AdminRepositoryImpl: Solicitando reservas para userId: $userId');
    final bookings = await _dataSource.getBookingsForUser(userId);
    print('AdminRepositoryImpl: Recibidas ${bookings.length} reservas');
    return bookings;
  }

  @override
  Future<List<Booking>> getBookingsForCar(int carId) async {
    return await _dataSource.getBookingsForCar(carId);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _dataSource.deleteUser(userId);
  }
}
