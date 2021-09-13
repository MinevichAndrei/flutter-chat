abstract class UserSignInRepository {
  Future<bool> isAuthenticated();
  String? getUserId();
  Future<void> authenticate();
  Future<bool> signOut();
}
