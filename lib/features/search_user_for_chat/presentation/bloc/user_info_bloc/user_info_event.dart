import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/search_user_for_chat/data/models/user_model.dart';

abstract class UsersInfoEvent extends Equatable {
  const UsersInfoEvent();

  @override
  List<Object> get props => [];
}

class UsersInfoLoaded extends UsersInfoEvent {
  final String user;

  const UsersInfoLoaded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User for load { todo: $user }';
}

class UsersInfoAdded extends UsersInfoEvent {
  final UserModel user;

  const UsersInfoAdded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'TodoAdded { todo: $user }';
}
