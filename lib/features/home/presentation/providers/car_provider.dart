// providers/car_provider.dart

import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/car_repository.dart';

class CarProvider with ChangeNotifier {
  final CarRepository carRepository;
  List<Car> cars = [];
  Car? selectedCar;
  bool isLoading = false;

  CarProvider(this.carRepository);

  Future<void> fetchCars() async {
    isLoading = true;
    notifyListeners();
    cars = await carRepository.getCars();
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCarById(int id) async {
    isLoading = true;
    notifyListeners();
    selectedCar = await carRepository.getCarById(id: id);
    isLoading = false;
    notifyListeners();
  }
}
