import 'package:equatable/equatable.dart';

abstract class CreateChatEvent extends Equatable {
  const CreateChatEvent();

  @override
  List<Object> get props => [];
}

class CreateChat extends CreateChatEvent {
  final String chatRoomId;
  final Map<String, dynamic> chatRoomInfoMap;

  const CreateChat({required this.chatRoomId, required this.chatRoomInfoMap});

  @override
  List<Object> get props => [chatRoomId, chatRoomInfoMap];
}
