import 'package:equatable/equatable.dart';

abstract class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends SendMessageEvent {
  final String chatRoomId;
  final String messageId;
  final Map<String, dynamic> messageInfoMap;

  const SendMessage(
      {required this.chatRoomId,
      required this.messageId,
      required this.messageInfoMap});

  @override
  List<Object> get props => [
        chatRoomId,
        messageId,
        messageInfoMap,
      ];
}

class UpdateLastMessage extends SendMessageEvent {
  final String chatRoomId;
  final Map<String, dynamic> lastMessageInfoMap;

  const UpdateLastMessage(
      {required this.chatRoomId, required this.lastMessageInfoMap});

  @override
  List<Object> get props => [
        chatRoomId,
        lastMessageInfoMap,
      ];
}
