import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required message,
    required sendBy,
    required ts,
    required imgUrl,
  }) : super(
          message: message,
          sendBy: sendBy,
          ts: ts,
          imgUrl: imgUrl,
        );

  MessageEntity toEntity() {
    return MessageEntity(
      message: message,
      sendBy: sendBy,
      ts: ts,
      imgUrl: imgUrl,
    );
  }

  static MessageModel fromEntity(MessageEntity entity) {
    return MessageModel(
      message: entity.message,
      sendBy: entity.sendBy,
      ts: entity.ts,
      imgUrl: entity.imgUrl,
    );
  }
}
