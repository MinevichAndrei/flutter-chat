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

    LocalStorageService().saveUserEmail(userDetails?.email);
    LocalStorageService().saveUserId(userDetails?.uid);
    LocalStorageService()
        .saveUserName(userDetails?.email!.replaceAll("@gmail.com", ""));
    LocalStorageService().saveDisplayName(userDetails?.displayName);
    LocalStorageService().saveUserProfileUrl(userDetails?.photoURL);

    Map<String, dynamic> userInfoMap = {
      "email": userDetails!.email,
      "username": userDetails.email!.replaceAll('@gmail.com', ''),
      "name": userDetails.displayName,
      'imgUrl': userDetails.photoURL,
    };

    FirebaseFirestore.instance
        .collection("users")
        .doc(userDetails.uid)
        .set(userInfoMap);
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
      LocalStorageService().saveUserEmail(userDetails.user?.email);
      LocalStorageService().saveUserId(userDetails.user?.uid);
      LocalStorageService()
          .saveUserName(userDetails.user?.email!.replaceAll("@gmail.com", ""));
      LocalStorageService().saveDisplayName("");
      LocalStorageService().saveUserProfileUrl("");

      Map<String, dynamic> userInfoMap = {
        "email": userDetails.user?.email,
        "username": userDetails.user?.email!.replaceAll('@gmail.com', ''),
        "name": "",
        'imgUrl': "",
      };

      FirebaseFirestore.instance
          .collection("users")
          .doc(userDetails.user?.uid)
          .set(userInfoMap);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
