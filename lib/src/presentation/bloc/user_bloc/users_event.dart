import 'package:equatable/equatable.dart';
import 'package:flutter_chat/src/domain/entities/user_entity.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent {
  final String username;

  GetUsersEvent({required this.username});
}

class UsersListUpdated extends UsersEvent {
  final List<UserEntity> userListEntity;

  const UsersListUpdated(this.userListEntity);

  @override
  List<Object> get props => [userListEntity];
}
