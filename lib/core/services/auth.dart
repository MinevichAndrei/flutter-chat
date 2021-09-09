import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/core/services/database.dart';
import 'package:flutter_chat/core/services/local_storage_service.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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

    DatabaseMethods()
        .addUserInfoToDB(userDetails.uid, userInfoMap)
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  Future signOut() async {
    await LocalStorageService().removeData();
    await auth.signOut();
  }
}
