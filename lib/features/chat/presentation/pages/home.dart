import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_state.dart';
import 'package:flutter_chat/features/chat/presentation/pages/search_screen.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_room_list.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/sign_out_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserFromLocalStorageBloc>(context)
      ..add(UserLoadedFromLocalStorage());
    return BlocBuilder<UserFromLocalStorageBloc, UserFromLocalStorageState>(
        builder: (context, state) {
      if (state is UserFromLocalStorageLoadSuccess) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: [
              SignOutWidget(),
            ],
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(myUserName: state.user.username),
                          ),
                        ),
                    child: Text("Поиск")),
                ChatRoomListWidget(myUserName: state.user.username)
              ],
            ),
          ),
        );
      }
      return Spinner();
    });
  }
}
