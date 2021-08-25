import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required userName,
    required email,
    required name,
    required profileUrlPic,
  }) : super(
          name: name,
          userName: userName,
          email: email,
          profileUrlPic: profileUrlPic,
        );

  factory UserModel.fromJson(QueryDocumentSnapshot doc) {
    return UserModel(
      userName: doc['username'],
      email: doc['email'],
      name: doc['name'],
      profileUrlPic: doc['imgUrl'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
        userName: userName,
        email: email,
        name: name,
        profileUrlPic: profileUrlPic);
  }
}
