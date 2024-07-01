import 'package:tour_del_norte_app/features/general_info/data/models/information.dart';

abstract class InformationRepository {
  Future<List<Information>> getInformation();
  Future<Information> getInformationById(int id);
}
