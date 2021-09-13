import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/core/services/database.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/users_event.dart';
import 'package:flutter_chat/features/chat/presentation/pages/search_screen.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_room_list.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/sign_out_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? myName = "", myProfilePic = "", myUserName = "", myEmail = "";
  var chatRoomsStream = Stream<QuerySnapshot>.empty();

  // getMyInfoFromSharedPreference() async {
  //   myName = await LocalStorageService().getDisplayName();
  //   myProfilePic = await LocalStorageService().getUserProfileUrl();
  //   myUserName = await LocalStorageService().getUserName();
  //   myEmail = await LocalStorageService().getUserEmail();
  // }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    // await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersBloc>(context)..add(UserLoadedFromLocalStorage());
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      if (state is UserLoadFromLocalStorageSuccess) {
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
                            builder: (context) => SearchScreen(),
                          ),
                        ),
                    child: Text("Поиск")),
                ChatRoomListWidget(
                    chatRoomsStream: chatRoomsStream,
                    myUserName: state.userFromLocalStorage.username)
              ],
            ),
          ),
        );
      }
      return Spinner();
    });
  }
}
