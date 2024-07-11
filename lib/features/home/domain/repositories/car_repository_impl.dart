import 'package:tour_del_norte_app/features/home/data/datasources/supabase_car_data_source.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/home/data/models/car_brand.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final CarDataSource _carDataSource;

  CarRepositoryImpl(this._carDataSource);

  @override
  Future<List<Car>> getCars() async {
    return await _carDataSource.getCars();
  }

  @override
  Future<Car> getCarById({required int id}) async {
    return await _carDataSource.getCarById(id: id);
  }

  @override
  Future<List<CarType>> getCarTypes() async {
    return await _carDataSource.getCarTypes();
  }

  @override
  Future<List<CarBrand>> getCarBrands() async {
    return await _carDataSource.getCarBrands();
  }
}
