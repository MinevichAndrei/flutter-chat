import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/src/common/widgets/spinner.dart';
import 'package:flutter_chat/src/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/src/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/src/presentation/widgets/search_list_user_tile.dart';
import 'package:flutter_chat/src/common/widgets/error_widget.dart' as error;

class SearchUsersListWidget extends StatelessWidget {
  final String myUserName;
  const SearchUsersListWidget({required this.myUserName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      print(state);
      if (state is UsersLoadInProgress) {
        return Spinner();
      } else if (state is UsersLoadSuccess) {
        print(state.users);
        return ListView.builder(
            itemCount: state.users.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchListUserTileWidget(
                profileUrl: state.users[index].imgUrl,
                name: state.users[index].name,
                username: state.users[index].username,
                email: state.users[index].email,
                myUserName: myUserName,
              );
            });
      } else if (state is UsersLoadFailure) {
        return Center(
          child: error.ErrorWidget(),
        );
      }
      return Spinner();
    });
  }
}
