import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<bool> signInWithEmail(
      {required String email, required String password});
  Future<bool> signUpWithEmail(
      {required String name, required String email, required String password});
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  bool isSignedIn();
}

class SupabaseAuthDataSourceImpl implements AuthDataSource {
  final _supabase = Supabase.instance.client;
  final _googleSignIn = GoogleSignIn(
    clientId:
        '312853938836-3ncofuqfnufa86ni89d77j9gkkqrtg77.apps.googleusercontent.com',
    serverClientId:
        '312853938836-md2o3ffm3sre618cpugaufhj3qn7gcjq.apps.googleusercontent.com',
  );

  @override
  Future<bool> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _supabase.auth.signInWithPassword(password: password, email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await _supabase.auth.signUp(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthResponse res = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      return res.session != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabase.auth.signOut();
  }

  @override
  bool isSignedIn() => _supabase.auth.currentUser != null;
}
