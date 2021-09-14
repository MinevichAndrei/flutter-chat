import 'package:flutter_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class ChatRepository {
  Stream<List<UserEntity>> searchUser(String username);
  Future<UserEntity> getUserInfo(String username);
  Future<void> addMessage(
      String chatRoomId, String messageId, Map<String, dynamic> messageInfoMap);
  Future<void> updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap);
  Future<void> createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap);
  Stream<List<MessageEntity>> getChatRoomMessages(String chatRoomId);
  Stream<List<ChatEntity>> getChatRooms(String myUsername);
  Future<UserEntity> getUserFromLocalStorage();
}
