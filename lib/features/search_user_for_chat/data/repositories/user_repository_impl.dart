import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/features/search_user_for_chat/data/models/chat_model.dart';
import 'package:flutter_chat/features/search_user_for_chat/data/models/message_model.dart';
import 'package:flutter_chat/features/search_user_for_chat/data/models/user_model.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/entities/chat_entity.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/entities/message_entity.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Stream<List<UserEntity>> users(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<UserEntity> getUser(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get()
        .then((value) {
      return UserModel.fromEntity(UserEntity.fromQuerySnapshot(value));
    });
  }

  @override
  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  @override
  Future<void> createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exist
      return;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  @override
  Stream<List<MessageEntity>> getChatRoomMessages(chatRoomId) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              MessageModel.fromEntity(MessageEntity.fromJson(doc.data())))
          .toList();
    });
  }

  @override
  Stream<List<ChatEntity>> getChatRooms(String myUsername) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatModel.fromEntity(ChatEntity.fromJson(doc.data())))
          .toList();
    });
  }

  @override
  Future<void> updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }
}
