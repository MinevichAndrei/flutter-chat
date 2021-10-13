import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';

abstract class ChatRoomMessagesEvent extends Equatable {
  const ChatRoomMessagesEvent();

  @override
  List<Object> get props => [];
}

class LoadMessages extends ChatRoomMessagesEvent {
  final String chatRoomId;

  const LoadMessages({required this.chatRoomId});

  @override
  List<Object> get props => [chatRoomId];
}

class ReceiveEvent extends ChatRoomMessagesEvent {
  final List<MessageEntity> messages;
  ReceiveEvent(this.messages);
}
