import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/services/chat_room_id_service.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/create_chat_bloc/create_chat_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/create_chat_bloc/create_chat_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/create_chat_bloc/create_chat_state.dart';
import 'package:flutter_chat/features/chat/presentation/pages/chat_screen.dart';

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
    return BlocBuilder<CreateChatBloc, CreateChatState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            var chatRoomId = ChatRoomIdService()
                .getChatRoomIdByUsernames(myUserName, username);
            Map<String, dynamic> chatRoomInfoMap = {
              "users": [myUserName, username],
              "name": name,
              "image": profileUrl,
            };
            context.read<CreateChatBloc>().add(CreateChat(
                chatRoomId: chatRoomId, chatRoomInfoMap: chatRoomInfoMap));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                    chatWithUsername: username,
                    name: name,
                    chatRoomId: chatRoomId),
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
      },
    );
  }
}
