import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_state.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_users_event.dart';

class SearchUserBloc extends Bloc<UserEvent, UserState> {
  final ChatRepository chatRepository;

  SearchUserBloc({required this.chatRepository}) : super(UserLoadInProgress());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SearchUser) {
      yield* _mapUsersLoadedEventToState(event.user);
    }
  }

  Stream<UserState> _mapUsersLoadedEventToState(String user) async* {
    try {
      final users = this.chatRepository.searchUser(user);
      List<UserEntity> listUsers = await users.first;
      yield UserLoadSuccess(users: listUsers);
    } catch (_) {
      yield UserLoadFailure();
    }
  }
}
