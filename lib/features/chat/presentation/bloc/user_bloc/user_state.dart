import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoadInProgress extends UsersState {}

class UsersLoadSuccess extends UsersState {
  final List<UserEntity> users;

  const UsersLoadSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class UserLoadFromLocalStorageSuccess extends UsersState {
  final UserEntity userFromLocalStorage;

  const UserLoadFromLocalStorageSuccess({required this.userFromLocalStorage});

  @override
  List<Object> get props => [userFromLocalStorage];
}

class UsersLoadFailure extends UsersState {}
