import 'package:tour_del_norte_app/features/general_info/data/datasources/supabase_information_source.dart';
import 'package:tour_del_norte_app/features/general_info/data/models/information.dart';
import 'package:tour_del_norte_app/features/general_info/domain/repositories/information_repository.dart';

class InformationRepositoryImpl implements InformationRepository {
  final InformationDataSource dataSource;

  InformationRepositoryImpl(this.dataSource);

  @override
  Future<List<Information>> getInformation() => dataSource.getInformation();

  @override
  Future<Information> getInformationById(int id) =>
      dataSource.getInformationById(id: id);
}
