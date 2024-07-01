import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/general_info/data/models/information.dart';

abstract class InformationDataSource {
  Future<List<Information>> getInformation();
  Future<Information> getInformationById({required int id});
}

class SupabaseInformationDataSourceImpl implements InformationDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<List<Information>> getInformation() async {
    final response = await _supabase.from('information').select();
    return response.map((info) => Information.fromJson(info)).toList();
  }

  @override
  Future<Information> getInformationById({required int id}) async {
    final response =
        await _supabase.from('information').select().eq('id', id).single();
    return Information.fromJson(response);
  }
}
