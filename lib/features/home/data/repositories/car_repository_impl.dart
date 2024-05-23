import 'package:tour_del_norte_app/features/home/data/datasources/supabase_car_data_source.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final datasources = SupabaseCarDataSourceImpl();
  @override
  Future<List<Car>> getCars() async {
    return await datasources.getCars();
  }

  @override
  Future<Car> getCarById({required int id}) async {
    return await datasources.getCarById(id: id);
  }
}
