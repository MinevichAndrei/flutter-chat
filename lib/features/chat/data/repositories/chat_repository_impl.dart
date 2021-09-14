import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/core/services/local_storage_service.dart';
import 'package:flutter_chat/features/chat/data/models/chat_model.dart';
import 'package:flutter_chat/features/chat/data/models/message_model.dart';
import 'package:flutter_chat/features/chat/data/models/user_model.dart';
import 'package:flutter_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Stream<List<UserEntity>> searchUser(String username) {
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
  Future<UserEntity> getUserInfo(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get()
        .then((value) {
      return UserModel.fromEntity(UserEntity.fromQuerySnapshot(value));
    });
  }

  @override
  Future<void> addMessage(String chatRoomId, String messageId,
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
          .map((doc) =>
              ChatModel.fromEntity(ChatEntity.fromDocumentSnapshot(doc)))
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

  @override
  Future<UserEntity> getUserFromLocalStorage() async {
    final String? myName = await LocalStorageService().getDisplayName();
    final String? myProfilePic =
        await LocalStorageService().getUserProfileUrl();
    final String? myUserName = await LocalStorageService().getUserName();
    final String? myEmail = await LocalStorageService().getUserEmail();

    return UserEntity(
        username: myUserName!,
        email: myEmail!,
        name: myName!,
        imgUrl: myProfilePic!);
  }
}
