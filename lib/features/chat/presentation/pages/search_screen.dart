import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_users_event.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/search_users_list.dart';

class SearchScreen extends StatefulWidget {
  final String myUserName;
  const SearchScreen({Key? key, required this.myUserName}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late bool isSearhing;
  TextEditingController searchUserNameEditingController =
      TextEditingController();

  @override
  void initState() {
    isSearhing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск'),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            context.read<SearchUserBloc>().add(SearchUser(
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
          SearchUsersListWidget(myUserName: widget.myUserName),
        ],
      ),
    );
  }
}
