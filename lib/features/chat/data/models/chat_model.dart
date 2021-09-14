import 'package:flutter_chat/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required id,
    required lastMessage,
    required lastMessageSendBy,
    required lastMessageSendTs,
    required users,
  }) : super(
          id: id,
          lastMessage: lastMessage,
          lastMessageSendBy: lastMessageSendBy,
          lastMessageSendTs: lastMessageSendTs,
          users: users,
        );

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      lastMessage: lastMessage,
      lastMessageSendBy: lastMessageSendBy,
      lastMessageSendTs: lastMessageSendTs,
      users: users,
    );
  }

  static ChatModel fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      lastMessage: entity.lastMessage,
      lastMessageSendBy: entity.lastMessageSendBy,
      lastMessageSendTs: entity.lastMessageSendTs,
      users: entity.users,
    );
  }
}
