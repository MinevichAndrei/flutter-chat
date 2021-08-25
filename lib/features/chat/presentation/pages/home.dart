import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/users_event.dart';
import 'package:flutter_chat/helper_functions/shared_preferences_helper.dart';
import 'package:flutter_chat/locator_service.dart';
import 'package:flutter_chat/services/auth.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:flutter_chat/features/chat/presentation/pages/sign_in.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/chat_room_list.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/search_users_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearhing = false;
  String? myName = "", myProfilePic = "", myUserName = "", myEmail = "";
  var chatRoomsStream = Stream<QuerySnapshot>.empty();
  TextEditingController searchUserNameEditingController =
      TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersListBloc>(
      create: (context) => sl<UsersListBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            InkWell(
              onTap: () {
                AuthMethods().signOut().then((s) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                });
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
                            isSearhing = false;
                            searchUserNameEditingController.text = "";
                            setState(() {});
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
                                sl<UsersListBloc>()
                                  ..add(GetUsersEvent(
                                      username: searchUserNameEditingController
                                          .text));
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
              SearchUsersListWidget(myUserName: myUserName!),
            ],
          ),
        ),
      ),
    );
  }
}
