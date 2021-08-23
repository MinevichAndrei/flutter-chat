import 'dart:math';

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

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      userName: snapshot['username'],
      email: snapshot['email'],
      name: snapshot['name'],
      profileUrlPic: snapshot['imgUrl'],
    );
  }
}
