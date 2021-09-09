import 'package:equatable/equatable.dart';
import 'package:flutter_chat/src/domain/entities/user_entity.dart';

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

  @override
  String toString() => 'UsersLoadSuccess { todos: $users }';
}

class UsersLoadFailure extends UsersState {}
