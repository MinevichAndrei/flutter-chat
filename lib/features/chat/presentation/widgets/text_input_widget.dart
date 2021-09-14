import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/send_message_bloc/send_message_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/send_message_bloc/send_message_state.dart';
import 'package:random_string/random_string.dart';

class TextInputWidget extends StatefulWidget {
  final String chatRoomId, imgUrl, username;
  const TextInputWidget(
      {Key? key,
      required this.username,
      required this.chatRoomId,
      required this.imgUrl})
      : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  String messageId = "";
  TextEditingController messageTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageBloc, SendMessageState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black.withOpacity(0.8),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: messageTextEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    addMessage(widget.username, widget.imgUrl,
                        widget.chatRoomId, false, state);
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  addMessage(String myUserName, String myProfilePic, String chatRoomId,
      bool sendClicked, SendMessageState state) {
    if (messageTextEditingController.text != "") {
      String message = messageTextEditingController.text;

      var lastMessageTs = DateTime.now();
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "imgUrl": myProfilePic,
      };

      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      BlocProvider.of<SendMessageBloc>(context)
        ..add(SendMessage(
            chatRoomId: chatRoomId,
            messageId: messageId,
            messageInfoMap: messageInfoMap));
      if (state is SendMessageLoadSuccess) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName,
        };

        BlocProvider.of<SendMessageBloc>(context)
          ..add(UpdateLastMessage(
              chatRoomId: chatRoomId, lastMessageInfoMap: lastMessageInfoMap));

        messageTextEditingController.text = "";
        BlocProvider.of<ChatRoomMessagesBloc>(context)
          ..add(LoadMessages(chatRoomId: chatRoomId));
        messageId = "";
      }
    }
  }
}
