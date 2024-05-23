import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<bool> singIn({
    required String email,
    required String password,
  });

  Future<bool> singUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> singOut();

  bool isSignedIn();
}

class SupabaseAuthDataSourceImpl implements AuthDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<bool> singIn({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> singUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> singOut() async {
    await _supabase.auth.signOut();
  }

  @override
  bool isSignedIn() => _supabase.auth.currentUser != null;
}
