import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/search_list_user_tile.dart';
import 'package:flutter_chat/common/widgets/error_widget.dart' as error;

class SearchUsersListWidget extends StatelessWidget {
  final String myUserName;
  const SearchUsersListWidget({required this.myUserName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListBloc, UsersState>(builder: (context, state) {
      if (state is UserEmpty || state is UsersLoading) {
        return Spinner();
      } else if (state is UsersLoaded) {
        return ListView.builder(
            itemCount: state.userList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchListUserTileWidget(
                profileUrl: state.userList[index].profileUrlPic,
                name: state.userList[index].name,
                username: state.userList[index].userName,
                email: state.userList[index].email,
                myUserName: myUserName,
              );
            });
      } else if (state is UsersError) {
        return Center(
          child: error.ErrorWidget(),
        );
      }
      return Spinner();
    });
  }
}
