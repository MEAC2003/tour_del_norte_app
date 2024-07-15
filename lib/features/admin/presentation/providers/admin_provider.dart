import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_brand.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/admin/data/models/payment.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/data/user_queue.dart';
import 'package:tour_del_norte_app/features/admin/domain/repositories/admin_repository.dart';

class AdminProvider extends ChangeNotifier {
  final AdminRepository _adminRepository;

  AdminProvider(this._adminRepository) {
    _startQueueProcessing();
  }
  void _startQueueProcessing() {
    _queueTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _userQueue.processQueue(_adminRepository);
    });
  }

  @override
  void dispose() {
    _queueTimer?.cancel();
    super.dispose();
  }

  List<Car> get cars => _filteredCars.isEmpty ? _cars : _filteredCars;
  List<Booking> _recentBookings = [];
  int _todayBookings = 0;
  int _availableCars = 0;
  double _totalRevenue = 0;
  List<Car> _cars = [];
  List<PublicUser> _users = [];
  List<PublicUser> _filteredUsers = [];
  String _searchQuery = '';
  List<CarType> _carTypes = [];
  List<CarBrand> _carBrands = [];

  List<CarType> get carTypes => _carTypes;
  List<CarBrand> get carBrands => _carBrands;

  List<PublicUser> get users => _searchQuery.isEmpty ? _users : _filteredUsers;
  List<Booking> get recentBookings => _recentBookings;
  int get todayBookings => _todayBookings;
  int get availableCars => _availableCars;
  double get totalRevenue => _totalRevenue;
  final UserQueue _userQueue = UserQueue();
  Timer? _queueTimer;

  List<Car> _filteredCars = [];

  Future<void> loadCars() async {
    _cars = await _adminRepository.getAllCars();
    _applyFilters();
    notifyListeners();
  }

  Future<void> updateCar(Car updatedCar) async {
    await _adminRepository.updateCar(updatedCar);
    final index = _cars.indexWhere((car) => car.id == updatedCar.id);
    if (index != -1) {
      _cars[index] = updatedCar;
      notifyListeners();
    }
  }

  Future<void> deleteCar(int carId) async {
    await _adminRepository.deleteCar(carId);
    _cars.removeWhere((car) => car.id == carId);
    notifyListeners();
  }

  Future<void> loadCarTypes() async {
    try {
      _carTypes = await _adminRepository.getAllCarTypes();
      notifyListeners();
    } catch (e) {
      print('Error al cargar los tipos de carro: $e');
    }
  }

  Future<void> loadCarBrands() async {
    try {
      _carBrands = await _adminRepository.getAllCarBrands();
      notifyListeners();
    } catch (e) {
      print('Error al cargar las marcas de carro: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _adminRepository.deleteUser(userId);
      _users.removeWhere((user) => user.id == userId);
      _filteredUsers.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (e) {
      print('Error deleting user: $e');
      // Aquí podrías manejar el error, por ejemplo, mostrando un mensaje al usuario
    }
  }

  void searchCars(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    if (_searchQuery.isEmpty) {
      _filteredCars = _cars;
    } else {
      _filteredCars = _cars
          .where(
              (car) => car.name?.toLowerCase().contains(_searchQuery) ?? false)
          .toList();
    }
  }

  void setSearchQuery(String query) {
    print('Search query: $query'); // Añade esta línea
    _searchQuery = query.toLowerCase();
    _filteredUsers = _users
        .where((user) =>
            user.fullName.toLowerCase().contains(_searchQuery) ||
            user.email.toLowerCase().contains(_searchQuery) ||
            user.dni!.toLowerCase().contains(_searchQuery))
        .toList();
    print('Filtered users: ${_filteredUsers.length}'); // Añade esta línea
    notifyListeners();
  }

  Future<void> loadDashboardData() async {
    try {
      _recentBookings = await _adminRepository.getRecentBookings(5);
      _todayBookings = await _adminRepository.getTodayBookingsCount();
      _availableCars = await _adminRepository.getAvailableCarsCount();
      _totalRevenue = await _adminRepository.getTotalRevenue();
      _cars = await _adminRepository.getAllCars();
      notifyListeners();
    } catch (e) {
      print('Error loading dashboard data: $e');
    }
  }

  Future<List<Booking>> getBookingsForCar(int carId) async {
    try {
      final bookings = await _adminRepository.getBookingsForCar(carId);
      return bookings;
    } catch (e) {
      print('Error al obtener las reservas del vehículo: $e');
      return [];
    }
  }

  Future<List<Booking>> getBookingsForUser(String userId) async {
    try {
      print('AdminProvider: Solicitando reservas para userId: $userId');
      final bookings = await _adminRepository.getBookingsForUser(userId);
      print('AdminProvider: Recibidas ${bookings.length} reservas');
      return bookings;
    } catch (e) {
      print('Error al obtener las reservas del usuario: $e');
      return [];
    }
  }

  Future<Payment?> getPaymentForBooking(int bookingId) async {
    return await _adminRepository.getPaymentForBooking(bookingId);
  }

  Future<void> loadUsers() async {
    try {
      _users = await _adminRepository.getAllUsers();
      _filteredUsers = _users;
      notifyListeners();
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  Future<void> toggleUserRole(String userId) async {
    try {
      final userIndex = _users.indexWhere((user) => user.id == userId);
      if (userIndex != -1) {
        final updatedUser = _users[userIndex].copyWith(
            role: _users[userIndex].role == 'admin' ? 'user' : 'admin');
        await _adminRepository.updateUser(updatedUser);
        _users[userIndex] = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      print('Error toggling user role: $e');
    }
  }

  Future<void> updateUser(PublicUser updatedUser) async {
    try {
      await _adminRepository.updateUser(updatedUser);
      final userIndex = _users.indexWhere((user) => user.id == updatedUser.id);
      if (userIndex != -1) {
        _users[userIndex] = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> addPendingUser(PublicUser user) async {
    try {
      final result = await _adminRepository.addPendingUser(user);
      if (result['success']) {
        _userQueue.addUser(user);
        _users.add(user.copyWith(id: result['userId']));
        notifyListeners();
      } else {
        print('Error adding user: ${result['error']}');
        // Aquí podrías mostrar un mensaje de error al usuario
      }
    } catch (e) {
      print('Error adding user: $e');
      // Manejo de errores adicional si es necesario
    }
  }

  Future<List<PublicUser>> getAllUsers() async {
    try {
      final users = await _adminRepository.getAllUsers();
      return users;
    } catch (e) {
      print('Error loading users: $e');
      return [];
    }
  }

  Future<bool> addCar(Car car) async {
    try {
      await _adminRepository.addCar(car);
      await loadCars(); // Recargar la lista de autos después de añadir uno nuevo
      return true;
    } catch (e, stackTrace) {
      print('Error al añadir el auto: $e');
      print('StackTrace: $stackTrace');
      return false;
    }
  }
}
