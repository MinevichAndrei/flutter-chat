import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/src/data/models/user_model.dart';

import 'package:flutter_chat/src/domain/entities/user_entity.dart';
import 'package:flutter_chat/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  // final UserRemoteDataSource userRemoteDataSource;
  // UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Stream<List<UserEntity>> users(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
