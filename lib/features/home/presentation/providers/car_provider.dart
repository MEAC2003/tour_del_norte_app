import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/data/models/car_brand.dart';
import 'package:tour_del_norte_app/features/home/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/car_repository.dart';

class CarProvider extends ChangeNotifier {
  final CarRepository _carRepository;
  List<Car> _cars = [];
  List<CarType> _carTypes = [];
  List<CarBrand> _carBrands = [];
  bool _isLoading = false;

  CarProvider(this._carRepository);

  List<Car> get cars => _cars;
  List<CarType> get carTypes => _carTypes;
  List<CarBrand> get carBrands => _carBrands;
  bool get isLoading => _isLoading;

  List<String> get carTypeNames =>
      _carTypes.map((type) => type.typeName).toList();
  List<String> get carBrandNames =>
      _carBrands.map((brand) => brand.name).toList();

  Future<void> loadCars() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cars = await _carRepository.getCars();
      _carTypes = await _carRepository.getCarTypes();
      _carBrands = await _carRepository.getCarBrands();
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Car? getCarById(int id) {
    return _cars.firstWhere((car) => car.id == id);
  }

  String getCarTypeName(int id) {
    return _carTypes
        .firstWhere((type) => type.id == id,
            orElse: () => CarType(id: -1, createdAt: '', typeName: 'Unknown'))
        .typeName;
  }

  String getCarBrandName(String name) {
    return _carBrands
        .firstWhere(
            (brand) => name.toLowerCase().startsWith(brand.name.toLowerCase()),
            orElse: () => CarBrand(id: -1, createdAt: '', name: 'Unknown'))
        .name;
  }
}
