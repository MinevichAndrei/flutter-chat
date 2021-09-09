import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/repositories/user_repository.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;

  UsersBloc({required this.userRepository}) : super(UsersLoadInProgress());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is UsersLoaded) {
      try {
        final users = this.userRepository.users(event.user);
        var a = await users.first;
        yield UsersLoadSuccess(users: a);
      } catch (_) {
        yield UsersLoadFailure();
      }
    }
  }
}
