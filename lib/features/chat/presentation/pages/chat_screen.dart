import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_state.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_messages_list_widget.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/text_input_widget.dart';

class ChatScreen extends StatelessWidget {
  final String chatWithUsername, name, chatRoomId;
  ChatScreen(
      {required this.chatWithUsername,
      required this.name,
      required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFromLocalStorageBloc, UserFromLocalStorageState>(
      builder: (context, state) {
        if (state is UserFromLocalStorageLoadSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(name),
            ),
            body: Container(
              child: Stack(
                children: [
                  ChatMessagesListWidget(
                      username: state.user.username, chatRoomId: chatRoomId),
                  TextInputWidget(
                      username: state.user.username,
                      chatRoomId: chatRoomId,
                      imgUrl: state.user.imgUrl),
                ],
              ),
            ),
          );
        }
        return Spinner();
      },
    );
  }
}
