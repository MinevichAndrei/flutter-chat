import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String email;
  final String name;
  final String imgUrl;

  const UserEntity(
      {required this.username,
      required this.email,
      required this.name,
      required this.imgUrl});

  Map<String, Object> toJson() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'imgUrl': imgUrl,
    };
  }

  @override
  String toString() {
    return 'UserEntity {username: $username, email: $email, name: $name, imgUrl: $imgUrl}';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    var doc = snap.data() as Map<String, dynamic>;
    return UserEntity(
      username: doc['username'],
      email: doc['email'],
      name: doc['name'],
      imgUrl: doc['imgUrl'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'imgUrl': imgUrl,
    };
  }

  @override
  List<Object?> get props => [
        username,
        email,
        name,
        imgUrl,
      ];
}
