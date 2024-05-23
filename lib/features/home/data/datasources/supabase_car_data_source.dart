import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';

abstract class CarDataSource {
  Future<List<Car>> getCars();
  Future<Car> getCarById({required int id});
}

class SupabaseCarDataSourceImpl implements CarDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<List<Car>> getCars() async {
    final response = await _supabase.from('car').select();
    print('getCars');
    print(response);
    return [];
    // final cars = response.
    // return cars.map((car) => Car.fromJson(car)).toList();
  }

  @override
  Future<Car> getCarById({required int id}) async {
    final response = await _supabase.from('car').select().eq('id', id).single();
    print('getCarById');
    print(response);
    return Car.fromJson(response);
  }
}
