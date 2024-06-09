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
    print('getInformation');
    print(response);
    return [];
    // final information = response.
    // return information.map((information) => Information.fromJson(information)).toList();
  }

  @override
  Future<Information> getInformationById({required int id}) async {
    final response =
        await _supabase.from('information').select().eq('id', id).single();
    print('getInformationById');
    print(response);
    return Information.fromJson(response);
  }
}
