import 'package:flutter/material.dart';

class ChatMessageTileWidget extends StatelessWidget {
  final String message;
  final bool sendByMe;
  const ChatMessageTileWidget(
      {Key? key, required this.message, required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomRight:
                    sendByMe ? Radius.circular(0) : Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: sendByMe ? Radius.circular(24) : Radius.circular(0),
              ),
              color: Colors.blue,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ],
    );
  }
}
