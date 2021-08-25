import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/usecases/get_user.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/users_event.dart';

class UsersListBloc extends Bloc<UsersEvent, UsersState> {
  final GetUserByUserName getUser;
  UsersListBloc({required this.getUser}) : super(UsersLoading());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is GetUsersEvent) {
      yield* _mapFetchOneNewsToState(event.username);
    } else if (event is UsersListUpdated) {
      yield* _mapUsersUpdateToState(event);
    }
  }

  Stream<UsersState> _mapFetchOneNewsToState(String username) async* {
    yield UsersLoading();
    getUser(UserParams(username: username))
        .listen((item) => add(UsersListUpdated(item)));
  }

  Stream<UsersState> _mapUsersUpdateToState(UsersListUpdated event) async* {
    yield UsersLoaded(event.userListEntity);
  }
}
