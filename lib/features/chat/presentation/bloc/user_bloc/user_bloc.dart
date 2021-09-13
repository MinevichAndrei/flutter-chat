import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final ChatRepository userRepository;

  UsersBloc({required this.userRepository}) : super(UsersLoadInProgress());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is UsersLoaded) {
      yield* _mapUsersLoadedEventToState(event);
    } else if (event is UserLoadedFromLocalStorage) {
      yield* _mapUserLoadedFRomLocalStorageEvent();
    }
  }

  Stream<UsersState> _mapUsersLoadedEventToState(UsersLoaded event) async* {
    try {
      final users = this.userRepository.users(event.user);
      var a = await users.first;
      yield UsersLoadSuccess(users: a);
    } catch (_) {
      yield UsersLoadFailure();
    }
  }

  Stream<UsersState> _mapUserLoadedFRomLocalStorageEvent() async* {
    try {
      final user = await this.userRepository.getUserFromLocalStorage();
      yield UserLoadFromLocalStorageSuccess(userFromLocalStorage: user);
    } catch (_) {
      yield UsersLoadFailure();
    }
  }
}
