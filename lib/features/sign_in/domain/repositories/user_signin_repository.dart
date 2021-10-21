abstract class UserSignInRepository {
  Future<bool> isAuthenticated();
  String? getUserId();
  Future<void> authenticate();
  Future<bool> signOut();

  // Sign with Email
  Future<String> signInEmail(String email, String password);
  Future<String> signUpEmail(String email, String password);
}
