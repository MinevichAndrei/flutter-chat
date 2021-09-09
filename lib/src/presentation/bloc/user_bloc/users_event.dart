import 'package:equatable/equatable.dart';
import 'package:flutter_chat/src/data/models/user_model.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersLoaded extends UsersEvent {
  final String user;

  const UsersLoaded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User for load { todo: $user }';
}

class UsersAdded extends UsersEvent {
  final UserModel user;

  const UsersAdded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'TodoAdded { todo: $user }';
}
