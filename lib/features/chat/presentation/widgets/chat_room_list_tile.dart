import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_state.dart';
import 'package:flutter_chat/features/chat/presentation/pages/chat_screen.dart';

class ChatRoomListTileWidget extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTileWidget(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileWidgetState createState() => _ChatRoomListTileWidgetState();
}

class _ChatRoomListTileWidgetState extends State<ChatRoomListTileWidget> {
  final String profilePicUrl = "", name = "";
  String username = "";

  @override
  void initState() {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    print(username);
    getUser();
    super.initState();
  }

  getUser() {
    context.read<UsersInfoBloc>().add(UsersInfoLoaded(username));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersInfoBloc, UsersInfoState>(
        builder: (context, state) {
      if (state is UsersInfoLoadInProgress) {
        return Spinner();
      } else if (state is UsersInfoLoadSuccess) {
        return Container(
          margin: EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                    chatWithUsername: username, name: state.user.name),
              ),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(state.user.imgUrl,
                      width: 40, height: 40, fit: BoxFit.cover),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    Text(state.user.name),
                    Text(widget.lastMessage),
                  ],
                ),
              ],
            ),
          ),
        );
      } else
        return Spinner();
    });
  }
}
