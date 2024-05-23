abstract class AuthRepository {
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
