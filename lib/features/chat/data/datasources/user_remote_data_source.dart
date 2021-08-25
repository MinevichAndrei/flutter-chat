import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/core/error/exception.dart';
import 'package:flutter_chat/features/chat/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Stream<List<UserModel>> getUser(String username);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Stream<List<UserModel>> getUser(String username) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: username)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => UserModel.fromJson(doc)).toList();
      });
    } catch (e) {
      throw ServerException();
    }
  }
}
