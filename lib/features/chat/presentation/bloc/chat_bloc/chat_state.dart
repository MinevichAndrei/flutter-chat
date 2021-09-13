import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/chat_entity.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitialState extends ChatsState {}

class ChatsLoadInProgress extends ChatsState {}

class ChatsLoadSuccess extends ChatsState {
  final List<ChatEntity> chats;

  const ChatsLoadSuccess({required this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatsLoadFailure extends ChatsState {}
