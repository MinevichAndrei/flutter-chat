import 'package:flutter/material.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:flutter_chat/views/chat_screen.dart';

class SearchListUserTileWidget extends StatelessWidget {
  final String profileUrl, name, username, email, myUserName;
  const SearchListUserTileWidget({
    required this.profileUrl,
    required this.name,
    required this.username,
    required this.email,
    required this.myUserName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username],
        };

        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatScreen(chatWithUsername: username, name: name),
          ),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileUrl),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(email),
            ],
          ),
        ],
      ),
    );
  }

  getChatRoomIdByUsernames(String? a, String? b) {
    if (a!.substring(0, 1).codeUnitAt(0) > b!.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
