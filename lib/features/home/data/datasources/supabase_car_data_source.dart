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
    try {
      final response = await _supabase.from('car').select();

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Car.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching cars: $e');
      rethrow;
    }
  }

  @override
  Future<Car> getCarById({required int id}) async {
    try {
      final response =
          await _supabase.from('car').select().eq('id', id).single();

      return Car.fromJson(response);
    } catch (e) {
      print('Error fetching car by id: $e');
      rethrow;
    }
  }
}
