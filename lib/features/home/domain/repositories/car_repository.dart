import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/home/data/models/car_brand.dart';

abstract class CarRepository {
  Future<List<Car>> getCars();
  Future<Car> getCarById({required int id});
  Future<List<CarType>> getCarTypes();
  Future<List<CarBrand>> getCarBrands();
}
