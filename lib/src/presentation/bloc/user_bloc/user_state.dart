import 'package:equatable/equatable.dart';
import 'package:flutter_chat/src/domain/entities/user_entity.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UserEmpty extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserEntity> userList;
  UsersLoaded([this.userList = const []]);
  @override
  List<Object> get props => [userList];
}

class UsersError extends UsersState {
  final String message;

  UsersError({required this.message});

  @override
  List<Object> get props => [message];
}
