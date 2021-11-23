import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_room_list_tile.dart';

class ChatRoomListWidget extends StatefulWidget {
  final String myUserName;
  ChatRoomListWidget({required this.myUserName});

  @override
  _ChatRoomListWidgetState createState() => _ChatRoomListWidgetState();
}

class _ChatRoomListWidgetState extends State<ChatRoomListWidget> {
  String username = "";
  @override
  void initState() {
    context.read<ChatsBloc>().add(AllChatsLoaded(widget.myUserName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        print("STATE: $state");
        if (state is ChatsLoadSuccess) {
          if (state.chats.length > 0) {
            return ListView.builder(
              itemCount: state.chats.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ChatEntity ds = state.chats[index];
                return ChatRoomListTileWidget(ds.lastMessage, ds.id, ds.name,
                    ds.image, widget.myUserName);
              },
            );
          } else {
            Text("Нет активных чатов");
          }
        } else if (state is ChatsLoadFailure) {
          Text(state.message);
        }
        return Text("Нет активных чатов");
      },
    );
  }
}
