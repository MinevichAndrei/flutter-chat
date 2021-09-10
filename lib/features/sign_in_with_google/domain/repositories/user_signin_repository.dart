import 'package:firebase_auth/firebase_auth.dart';

abstract class UserSignInRepository {
  Future<bool> isAuthenticated();
  String? getUserId();
  Future<void> authenticate();
  Future<bool> signOut();
}
