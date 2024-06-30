import 'package:tour_del_norte_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tour_del_norte_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<bool> signInWithEmail(
      {required String email, required String password}) {
    return _authDataSource.signInWithEmail(email: email, password: password);
  }

  @override
  Future<bool> signUpWithEmail(
      {required String name, required String email, required String password}) {
    return _authDataSource.signUpWithEmail(
        name: name, email: email, password: password);
  }

  @override
  Future<bool> signInWithGoogle() {
    return _authDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }

  @override
  bool isSignedIn() {
    return _authDataSource.isSignedIn();
  }
}
