import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/core/error/exception.dart';
import 'package:flutter_chat/features/chat/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<dynamic> getUser(String username);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<dynamic> getUser(String username) async {
    var usersStream = Stream<QuerySnapshot>.empty();
    try {
      usersStream = FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: username)
          .snapshots();
      return usersStream.forEach((field) {
        field.docs.map((item) => UserModel.fromJson(item)).toList();
      });
    } catch (e) {
      throw ServerException();
    }
  }
}
