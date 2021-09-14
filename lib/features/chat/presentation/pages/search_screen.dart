import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_users_event.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/search_users_list.dart';

class SearchScreen extends StatelessWidget {
  final String myUserName;
  final TextEditingController searchUserNameEditingController =
      TextEditingController();
  SearchScreen({Key? key, required this.myUserName}) : super(key: key);

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
          SearchUsersListWidget(myUserName: myUserName),
        ],
      ),
    );
  }
}
