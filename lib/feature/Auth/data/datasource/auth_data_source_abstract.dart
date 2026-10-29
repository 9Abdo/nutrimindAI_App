abstract class AuthDataSourceAbstract {
  Future<void> login({required String email, required String password});
  Future<void> signUp({
    required String email,
    required String password,
    required String fullname,
  });
}
