import 'package:equatable/equatable.dart';

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
}

class UserLoadedFromLocalStorage extends UsersEvent {}
