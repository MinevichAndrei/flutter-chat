import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static String userIdKey = "USER_KEY";
  static String userNameKey = 'USER_NAME_KEY';
  static String displayNameKey = "USER_DISPLAY_NAME_KEY";
  static String userEmailKey = "USER_EMAIL_KEY";
  static String userProfilePicKey = "USER_PROFILE_PIC_KEY";

  // save data
  Future<bool> saveUserName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName!);
  }

  Future<bool> saveUserEmail(String? getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail!);
  }

  Future<bool> saveUserId(String? getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId!);
  }

  Future<bool> saveDisplayName(String? getDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getDisplayName!);
  }

  Future<bool> saveUserProfileUrl(String? getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePicKey, getUserProfile!);
  }

  // get data
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  // remove data
  Future<bool> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
