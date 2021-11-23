import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/core/services/local_storage_service.dart';
import 'package:flutter_chat/features/sign_in/domain/repositories/user_signin_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserSignInRepositoryImpl implements UserSignInRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> authenticate() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;
    setUsers(userDetails!);
  }

  String? getUserId() => _firebaseAuth.currentUser?.uid;

  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<bool> signOut() async {
    try {
      await LocalStorageService().removeData();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> signInEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Future<String> signUpEmail(String email, String password) async {
    try {
      final userDetails = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      setUsers(userDetails.user!);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  @override
  void setUsers(User user) {
    LocalStorageService().saveUserEmail(user.email);
    LocalStorageService().saveUserId(user.uid);
    LocalStorageService().saveUserName(user.email!.split('@')[0]);
    user.displayName != null
        ? LocalStorageService().saveDisplayName(user.displayName)
        : LocalStorageService().saveDisplayName(user.email!.split('@')[0]);
    user.photoURL != null
        ? LocalStorageService().saveUserProfileUrl(user.photoURL)
        : LocalStorageService().saveUserProfileUrl("");

    Map<String, dynamic> userInfoMap = {
      "email": user.email,
      "username": user.email!.split('@')[0],
      "name": user.displayName != null
          ? user.displayName
          : user.email!.split('@')[0],
      'imgUrl': user.photoURL != null ? user.photoURL : "",
    };

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(userInfoMap);
  }
}
