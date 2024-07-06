import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/car_repository.dart';

class CarProvider extends ChangeNotifier {
  final CarRepository _carRepository;
  List<Car> _cars = [];
  bool _isLoading = false;

  CarProvider(this._carRepository);

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;

  Future<void> loadCars() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cars = await _carRepository.getCars();
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Car? getCarById(int id) {
    return _cars.firstWhere((car) => car.id == id);
  }
}
