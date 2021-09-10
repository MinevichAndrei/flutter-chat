import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/widgets/chat_room_list_tile.dart';

class ChatRoomListWidget extends StatelessWidget {
  final Stream<QuerySnapshot> chatRoomsStream;
  final String myUserName;
  ChatRoomListWidget({required this.chatRoomsStream, required this.myUserName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return ChatRoomListTileWidget(
                      ds["lastMessage"], ds.id, myUserName);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
