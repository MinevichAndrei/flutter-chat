import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/users_event.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

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

  // @override
  // void dispose() {
  //   searchUserNameEditingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Поиск'),
          ),
          body: Row(
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
        );
      },
    );
  }
}
