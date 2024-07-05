import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tour_del_norte_app/features/auth/domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  AuthProvider(this._authRepository) {
    _initializeSession();
  }

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  Future<void> _initializeSession() async {
    _currentUser = Supabase.instance.client.auth.currentUser;
    notifyListeners();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      _currentUser = data.session?.user;
      notifyListeners();
    });
  }

  void _handleAuthResult(AuthResult result) {
    if (result.success) {
      _currentUser = Supabase.instance.client.auth.currentUser;
      _errorMessage = null;
    } else {
      _errorMessage = result.error ?? 'Error de autenticación';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthResult> signInWithEmail(String email, String password) async {
    return _performAuthAction(() => _authRepository.signInWithEmail(
          email: email,
          password: password,
        ));
  }

  Future<AuthResult> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return _performAuthAction(() => _authRepository.signUpWithEmail(
          fullName: fullName,
          email: email,
          password: password,
        ));
  }

  Future<AuthResult> signInWithGoogle() async {
    return _performAuthAction(() => _authRepository.signInWithGoogle());
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _currentUser = null;
    notifyListeners();
  }

  Future<AuthResult> _performAuthAction(
      Future<AuthResult> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await action();
      if (result.success) {
        _currentUser = Supabase.instance.client.auth.currentUser;
      } else {
        _errorMessage = result.error ?? "Authentication failed";
      }
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return AuthResult(success: false, isNewUser: false, error: _errorMessage);
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is AuthException) {
      switch (error.message) {
        case 'Invalid login credentials':
          return 'Email o contraseña incorrectos';
        case 'Email not confirmed':
          return 'Por favor, confirme su email antes de iniciar sesión';
        default:
          return 'Error de autenticación: ${error.message}';
      }
    }
    return 'Ocurrió un error inesperado';
  }

  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.resetPassword(email);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage =
          'No se pudo enviar el email de recuperación: ${_getErrorMessage(e)}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Nuevo método para verificar el estado de autenticación
  Future<void> checkAuthStatus() async {
    _currentUser = Supabase.instance.client.auth.currentUser;
    notifyListeners();
  }
}
