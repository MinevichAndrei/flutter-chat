import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final List<UserEntity> users;

  const UserLoadSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class UserLoadFailure extends UserState {}
