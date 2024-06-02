import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<bool> signIn({
    required String email,
    required String password,
  });

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();

  bool isSignedIn();
}

class SupabaseAuthDataSourceImpl implements AuthDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<bool> signIn({
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
  Future<bool> signUp({
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
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  bool isSignedIn() => _supabase.auth.currentUser != null;
}
