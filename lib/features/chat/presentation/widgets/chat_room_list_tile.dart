import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_state.dart';
import 'package:flutter_chat/features/chat/presentation/pages/chat_screen.dart';

class ChatRoomListTileWidget extends StatelessWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTileWidget(this.lastMessage, this.chatRoomId, this.myUsername);
  final String profilePicUrl = "", name = "";

  @override
  Widget build(BuildContext context) {
    String username = chatRoomId.replaceAll(myUsername, "").replaceAll("_", "");
    context.read<UsersInfoBloc>().add(UsersInfoLoaded(username));
    return BlocBuilder<UsersInfoBloc, UsersInfoState>(
        builder: (context, state) {
      if (state is UsersInfoLoadInProgress) {
        return Spinner();
      } else if (state is UsersInfoLoadSuccess) {
        return Row(
          children: [
            ClipOval(
              child: Image.network(state.user.imgUrl,
                  width: 40, height: 40, fit: BoxFit.cover),
            ),
            SizedBox(
              width: 12,
            ),
            GestureDetector(
              child: Column(
                children: [
                  Text(state.user.name),
                  Text(lastMessage),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      chatWithUsername: username, name: state.user.name),
                ),
              ),
            ),
          ],
        );
      } else
        return Spinner();
    });
  }
}
