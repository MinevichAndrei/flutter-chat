import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String message;
  final String sendBy;
  final Timestamp ts;
  final String imgUrl;

  const MessageEntity({
    required this.message,
    required this.sendBy,
    required this.ts,
    required this.imgUrl,
  });

  Map<String, Object> toJson() {
    return {
      'message': message,
      'sendBy': sendBy,
      'ts': ts,
      'imgUrl': imgUrl,
    };
  }

  static MessageEntity fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      message: json['message'] as String,
      sendBy: json['sendBy'] as String,
      ts: json['ts'] as Timestamp,
      imgUrl: json['imgUrl'] as String,
    );
  }

  static MessageEntity fromSnapshot(DocumentSnapshot snap) {
    var doc = snap.data() as Map<String, dynamic>;
    return MessageEntity(
      message: doc['message'],
      sendBy: doc['sendBy'],
      ts: doc['ts'],
      imgUrl: doc['imgUrl'],
    );
  }

  static MessageEntity fromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> snap) {
    return MessageEntity(
      message: snap.docs[0]['message'],
      sendBy: snap.docs[0]['sendBy'],
      ts: snap.docs[0]['ts'],
      imgUrl: snap.docs[0]['imgUrl'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'message': message,
      'sendBy': sendBy,
      'ts': ts,
      'imgUrl': imgUrl,
    };
  }

  @override
  List<Object?> get props => [
        message,
        sendBy,
        ts,
        imgUrl,
      ];
}
