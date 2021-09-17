import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

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
}

class ReceiveEvent extends UsersInfoEvent {
  final UserEntity user;
  ReceiveEvent(this.user);
}
