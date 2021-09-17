import 'package:equatable/equatable.dart';
import 'package:flutter_chat/features/chat/domain/entities/chat_entity.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class AllChatsLoaded extends ChatsEvent {
  final String userName;

  const AllChatsLoaded(this.userName);

  @override
  List<Object> get props => [userName];
}

class ReceiveEvent extends ChatsEvent {
  final List<ChatEntity> chats;
  ReceiveEvent(this.chats);
}
