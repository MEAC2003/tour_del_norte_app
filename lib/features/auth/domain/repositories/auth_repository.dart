abstract class AuthRepository {
  Future<bool> signInWithEmail(
      {required String email, required String password});
  Future<bool> signUpWithEmail(
      {required String name, required String email, required String password});
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  bool isSignedIn();
}
