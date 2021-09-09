import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required username,
    required email,
    required name,
    required imgUrl,
  }) : super(
          name: name,
          username: username,
          email: email,
          imgUrl: imgUrl,
        );

  @override
  int get hashCode =>
      username.hashCode ^ email.hashCode ^ name.hashCode ^ imgUrl.hashCode;

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      email: email,
      name: name,
      imgUrl: imgUrl,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      username: entity.username,
      email: entity.email,
      name: entity.name,
      imgUrl: entity.imgUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          email == other.email &&
          name == other.name &&
          imgUrl == other.imgUrl;

  @override
  String toString() {
    return 'UserModel {username: $username, email: $email, name: $name, imgUrl: $imgUrl}';
  }
}
