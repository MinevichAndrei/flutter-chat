import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_state.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_message_tile.dart';

class ChatMessagesListWidget extends StatefulWidget {
  final String username;
  final String chatRoomId;
  const ChatMessagesListWidget(
      {Key? key, required this.username, required this.chatRoomId})
      : super(key: key);

  _ChatMessagesListWidgetState createState() => _ChatMessagesListWidgetState();
}

class _ChatMessagesListWidgetState extends State<ChatMessagesListWidget> {
  @override
  void initState() {
    BlocProvider.of<ChatRoomMessagesBloc>(context)
      ..add(LoadMessages(chatRoomId: widget.chatRoomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomMessagesBloc, ChatRoomMessagesState>(
        builder: (context, state) {
      if (state is ChatRoomMessagesInitialState) {
        return Spinner();
      } else if (state is ChatRoomMessagesLoadSuccess) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 70, top: 16),
          itemCount: state.messages.length,
          reverse: true,
          itemBuilder: (context, index) {
            MessageEntity ms = state.messages[index];
            String time = ms.ts.toDate().hour.toString() +
                ":" +
                ms.ts.toDate().minute.toString();
            return ChatMessageTileWidget(
                message: ms.message,
                sendByMe: widget.username == ms.sendBy,
                ts: time);
          },
        );
      } else if (state is ChatRoomMessagesLoadFailure) {
        return Text('Error');
      }
      return Spinner();
    });
  }
}
