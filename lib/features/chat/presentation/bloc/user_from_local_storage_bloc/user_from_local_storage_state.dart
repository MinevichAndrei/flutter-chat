import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class UserFromLocalStorageState extends Equatable {
  const UserFromLocalStorageState();

  @override
  List<Object> get props => [];
}

class UserFromLocalStorageInitialState extends UserFromLocalStorageState {}

class UserFromLocalStorageLoadInProgress extends UserFromLocalStorageState {}

class UserFromLocalStorageLoadSuccess extends UserFromLocalStorageState {
  final UserEntity user;

  const UserFromLocalStorageLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class UserFromLocalStorageLoadFailure extends UserFromLocalStorageState {}
