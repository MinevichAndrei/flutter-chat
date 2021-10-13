import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final String lastMessage;
  final String lastMessageSendBy;
  final Timestamp lastMessageSendTs;
  final List<String> users;
  final String name;
  final String image;

  const ChatEntity({
    required this.id,
    required this.lastMessage,
    required this.lastMessageSendBy,
    required this.lastMessageSendTs,
    required this.users,
    required this.name,
    required this.image,
  });

  Map<String, Object> toJson() {
    return {
      'lastMessage': lastMessage,
      'lastMessageSendBy': lastMessageSendBy,
      'lastMessageSendTs': lastMessageSendTs,
      'users': users,
      'name': name,
      'image': image,
    };
  }

  static ChatEntity fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    var doc = snap.data();
    return ChatEntity(
      id: snap.id,
      lastMessage: doc['lastMessage'],
      lastMessageSendBy: doc['lastMessageSendBy'],
      lastMessageSendTs: doc['lastMessageSendTs'],
      users: (doc['users'] as List<dynamic>).map((e) => e as String).toList(),
      name: doc['name'],
      image: doc['image'],
    );
  }

  static ChatEntity fromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> snap) {
    return ChatEntity(
      id: snap.docs[0].id,
      lastMessage: snap.docs[0]['lastMessage'],
      lastMessageSendBy: snap.docs[0]['lastMessageSendBy'],
      lastMessageSendTs: snap.docs[0]['lastMessageSendTs'],
      users: (snap.docs[0]['users'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: snap.docs[0]['name'],
      image: snap.docs[0]['image'],
    );
  }

  @override
  List<Object?> get props => [
        lastMessage,
        lastMessageSendBy,
        lastMessageSendTs,
        users,
        name,
        image,
      ];
}
