import 'package:flutter_chat/features/search_user_for_chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required lastMessage,
    required lastMessageSendBy,
    required lastMessageSendTs,
    required users,
  }) : super(
          lastMessage: lastMessage,
          lastMessageSendBy: lastMessageSendBy,
          lastMessageSendTs: lastMessageSendTs,
          users: users,
        );

  ChatEntity toEntity() {
    return ChatEntity(
      lastMessage: lastMessage,
      lastMessageSendBy: lastMessageSendBy,
      lastMessageSendTs: lastMessageSendTs,
      users: users,
    );
  }

  static ChatModel fromEntity(ChatEntity entity) {
    return ChatModel(
      lastMessage: entity.lastMessage,
      lastMessageSendBy: entity.lastMessageSendBy,
      lastMessageSendTs: entity.lastMessageSendTs,
      users: entity.users,
    );
  }
}
