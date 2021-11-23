import 'package:firebase_auth/firebase_auth.dart';

abstract class UserSignInRepository {
  Future<bool> isAuthenticated();
  String? getUserId();
  Future<void> authenticate();
  Future<bool> signOut();
  void setUsers(User user);

  // Sign with Email
  Future<String> signInEmail(String email, String password);
  Future<String> signUpEmail(String email, String password);
}
