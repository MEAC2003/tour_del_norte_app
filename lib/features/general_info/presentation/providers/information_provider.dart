import 'package:flutter/foundation.dart';
import 'package:tour_del_norte_app/features/general_info/data/models/information.dart';
import 'package:tour_del_norte_app/features/general_info/domain/repositories/information_repository.dart';

class InformationProvider extends ChangeNotifier {
  final InformationRepository repository;

  InformationProvider(this.repository);

  Information? _information;
  bool _isLoading = false;
  String? _error;

  Information? get information => _information;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadInformation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final infoList = await repository.getInformation();
      if (infoList.isNotEmpty) {
        _information = infoList.first;
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
