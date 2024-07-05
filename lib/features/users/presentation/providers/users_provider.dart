import 'package:flutter/foundation.dart';
import 'package:tour_del_norte_app/features/users/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/users/domain/repositories/users_repository.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';

class UserProvider extends ChangeNotifier {
  final UsersRepository _repository;
  AuthProvider _authProvider;
  PublicUser? _user;
  bool _isLoading = false;
  String? _error;

  UserProvider(this._repository, {required AuthProvider authProvider})
      : _authProvider = authProvider {
    _authProvider.addListener(_onAuthStateChanged);
    _onAuthStateChanged();
  }

  PublicUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void updateAuthProvider(AuthProvider authProvider) {
    if (_authProvider != authProvider) {
      _authProvider.removeListener(_onAuthStateChanged);
      _authProvider = authProvider;
      _authProvider.addListener(_onAuthStateChanged);
      _onAuthStateChanged();
    }
  }

  void _onAuthStateChanged() {
    if (_authProvider.isAuthenticated) {
      getCurrentUser();
    } else {
      clearUser();
    }
  }

  Future<void> getCurrentUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _repository.getCurrentUser();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  Future<void> updateUser(PublicUser user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.updateUser(user);
      _user = user;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authProvider.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
