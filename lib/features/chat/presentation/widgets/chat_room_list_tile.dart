import 'package:flutter/material.dart';
import 'package:flutter_chat/features/chat/presentation/pages/chat_screen.dart';

class ChatRoomListTileWidget extends StatelessWidget {
  final String lastMessage, chatRoomId, myUsername, name, imageUrl;
  ChatRoomListTileWidget(this.lastMessage, this.chatRoomId, this.name,
      this.imageUrl, this.myUsername);

  @override
  Widget build(BuildContext context) {
    String username = chatRoomId.replaceAll(myUsername, "").replaceAll("_", "");
    return Container(
      margin: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
                chatWithUsername: username, name: name, chatRoomId: chatRoomId),
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl,
                      width: 40, height: 40, fit: BoxFit.cover)
                  : Text(username),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(name),
                Text(lastMessage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
