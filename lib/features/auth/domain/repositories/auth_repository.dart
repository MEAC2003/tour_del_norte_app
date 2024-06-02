abstract class AuthRepository {
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
