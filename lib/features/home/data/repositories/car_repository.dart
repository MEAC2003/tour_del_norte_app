import 'package:tour_del_norte_app/features/home/data/models/car.dart';

abstract class CarRepository {
  Future<List<Car>> getCars();
  Future<Car> getCarById({required int id});
}
