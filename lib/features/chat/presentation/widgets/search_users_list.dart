import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/error_widget.dart' as error;
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_state.dart';

import 'package:flutter_chat/features/chat/presentation/widgets/search_list_user_tile.dart';

class SearchUsersListWidget extends StatelessWidget {
  final String myUserName;
  const SearchUsersListWidget({required this.myUserName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadInProgress) {
        return Container();
      } else if (state is UserLoadSuccess) {
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
      } else if (state is UserLoadFailure) {
        return Center(
          child: error.ErrorWidget(),
        );
      }
      return Container();
    });
  }
}
