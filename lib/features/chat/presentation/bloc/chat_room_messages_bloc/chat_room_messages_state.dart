import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';

abstract class ChatRoomMessagesState extends Equatable {
  const ChatRoomMessagesState();

  @override
  List<Object> get props => [];
}

class ChatRoomMessagesInitialState extends ChatRoomMessagesState {}

class ChatRoomMessagesLoadInProgress extends ChatRoomMessagesState {}

class ChatRoomMessagesLoadSuccess extends ChatRoomMessagesState {
  final List<MessageEntity> messages;

  const ChatRoomMessagesLoadSuccess({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatRoomMessagesLoadFailure extends ChatRoomMessagesState {}
