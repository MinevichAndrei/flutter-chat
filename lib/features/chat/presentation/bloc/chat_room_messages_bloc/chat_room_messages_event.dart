import 'package:equatable/equatable.dart';

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
