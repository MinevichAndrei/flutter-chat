import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class UsersInfoState extends Equatable {
  const UsersInfoState();

  @override
  List<Object> get props => [];
}

class UsersInfoLoadInProgress extends UsersInfoState {}

class UsersInfoLoadSuccess extends UsersInfoState {
  final UserEntity user;

  const UsersInfoLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UsersLoadSuccess { todos: $user }';
}

class UsersInfoLoadFailure extends UsersInfoState {}
