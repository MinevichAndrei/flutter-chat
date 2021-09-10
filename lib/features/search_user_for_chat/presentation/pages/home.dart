import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/services/database.dart';
import 'package:flutter_chat/core/services/local_storage_service.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/users_event.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_event.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/widgets/chat_room_list.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/widgets/search_users_list.dart';
import 'package:flutter_chat/main_application_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool isSearhing;
  String? myName = "", myProfilePic = "", myUserName = "", myEmail = "";
  var chatRoomsStream = Stream<QuerySnapshot>.empty();
  TextEditingController searchUserNameEditingController =
      TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await LocalStorageService().getDisplayName();
    myProfilePic = await LocalStorageService().getUserProfileUrl();
    myUserName = await LocalStorageService().getUserName();
    myEmail = await LocalStorageService().getUserEmail();
    print("$myName, $myProfilePic, $myUserName, $myEmail");
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    isSearhing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      print(state);
      print("$myName, $myProfilePic, $myUserName, $myEmail");
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            InkWell(
              onTap: () {
                context.read<SignInWithGoogleBloc>().add(AppExit());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainApplicationScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  isSearhing
                      ? GestureDetector(
                          onTap: () {
                            searchUserNameEditingController.text = "";
                            setState(() {
                              isSearhing = false;
                            });
                          },
                          child: Padding(
                            child: Icon(Icons.arrow_back),
                            padding: EdgeInsets.only(right: 12),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: searchUserNameEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'username',
                            ),
                          )),
                          GestureDetector(
                            onTap: () {
                              if (searchUserNameEditingController.text != "") {
                                context.read<UsersBloc>().add(UsersLoaded(
                                    searchUserNameEditingController.text));
                                setState(() {
                                  isSearhing = true;
                                });
                              }
                            },
                            child: Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              isSearhing
                  ? SearchUsersListWidget(myUserName: myUserName!)
                  : ChatRoomListWidget(
                      chatRoomsStream: chatRoomsStream,
                      myUserName: myUserName!),
            ],
          ),
        ),
      );
    });
  }
}
