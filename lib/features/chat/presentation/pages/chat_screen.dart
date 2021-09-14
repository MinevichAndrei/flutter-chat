import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/core/services/chat_room_id_service.dart';
import 'package:flutter_chat/core/services/database.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_state.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_messages_list_widget.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name;
  ChatScreen({required this.chatWithUsername, required this.name});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId = "", messageId = "";
  var messageStream = Stream<QuerySnapshot>.empty();
  TextEditingController messageTextEditingController = TextEditingController();

  addMessage(String myUserName, String myProfilePic, String chatRoomId,
      bool sendClicked) {
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

      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName,
        };

        DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (!sendClicked) {
          // remove the text in the message input field
          messageTextEditingController.text = "";
          BlocProvider.of<ChatRoomMessagesBloc>(context)
            ..add(LoadMessages(chatRoomId: chatRoomId));

          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFromLocalStorageBloc, UserFromLocalStorageState>(
        builder: (context, state) {
      if (state is UserFromLocalStorageLoadSuccess) {
        chatRoomId = ChatRoomIdService().getChatRoomIdByUsernames(
            widget.chatWithUsername, state.user.username);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.name),
          ),
          body: Container(
            child: Stack(
              children: [
                ChatMessagesListWidget(
                    username: state.user.username, chatRoomId: chatRoomId),
                Container(
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
                            addMessage(state.user.username, state.user.imgUrl,
                                chatRoomId, false);
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Spinner();
    });
  }
}
