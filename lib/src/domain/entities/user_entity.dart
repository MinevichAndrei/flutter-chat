import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String email;
  final String name;
  final String profileUrlPic;

  const UserEntity(
      {required this.userName,
      required this.email,
      required this.name,
      required this.profileUrlPic});

  @override
  List<Object?> get props => [
        userName,
        email,
        name,
        profileUrlPic,
      ];
}
