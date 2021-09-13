import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String lastMessage;
  final String lastMessageSendBy;
  final Timestamp lastMessageSendTs;
  final List<String> users;

  const ChatEntity({
    required this.lastMessage,
    required this.lastMessageSendBy,
    required this.lastMessageSendTs,
    required this.users,
  });

  Map<String, Object> toJson() {
    return {
      'lastMessage': lastMessage,
      'lastMessageSendBy': lastMessageSendBy,
      'lastMessageSendTs': lastMessageSendTs,
      'users': users,
    };
  }

  static ChatEntity fromJson(Map<String, dynamic> json) {
    return ChatEntity(
      lastMessage: json['lastMessage'] as String,
      lastMessageSendBy: json['lastMessageSendBy'] as String,
      lastMessageSendTs: json['lastMessageSendTs'] as Timestamp,
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  static ChatEntity fromSnapshot(DocumentSnapshot snap) {
    var doc = snap.data() as Map<String, dynamic>;
    return ChatEntity(
      lastMessage: doc['lastMessage'],
      lastMessageSendBy: doc['lastMessageSendBy'],
      lastMessageSendTs: doc['lastMessageSendTs'],
      users: doc['users'],
    );
  }

  static ChatEntity fromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> snap) {
    return ChatEntity(
      lastMessage: snap.docs[0]['lastMessage'],
      lastMessageSendBy: snap.docs[0]['lastMessageSendBy'],
      lastMessageSendTs: snap.docs[0]['lastMessageSendTs'],
      users: snap.docs[0]['users'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'lastMessage': lastMessage,
      'lastMessageSendBy': lastMessageSendBy,
      'lastMessageSendTs': lastMessageSendTs,
      'users': users,
    };
  }

  @override
  List<Object?> get props => [
        lastMessage,
        lastMessageSendBy,
        lastMessageSendTs,
        users,
      ];
}
