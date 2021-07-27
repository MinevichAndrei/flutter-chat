import 'package:flutter/material.dart';
import 'package:flutter_chat/helper_functions/shared_preferences_helper.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name;
  ChatScreen({required this.chatWithUsername, required this.name});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId = "", messageId = "";
  String? myName = "", myProfilePic = "", myUserName = "", myEmail = "";
  TextEditingController messageTextEditingController = TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUsernames(widget.chatWithUsername, myUserName);
  }

  getChatRoomIdByUsernames(String a, String? b) {
    if (a.substring(0, 1).codeUnitAt(0) > b!.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
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

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEditingController.text = "";

          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  getAndSetMessages() async {}

  doThisLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        child: Stack(
          children: [
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
                      onChanged: (value) {
                        addMessage(false);
                      },
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
                        addMessage(true);
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
}
