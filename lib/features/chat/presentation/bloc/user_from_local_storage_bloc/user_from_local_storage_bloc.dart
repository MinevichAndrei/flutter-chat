import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_state.dart';

class UserFromLocalStorageBloc
    extends Bloc<UserFromLocalStorageEvent, UserFromLocalStorageState> {
  final ChatRepository chatRepository;

  UserFromLocalStorageBloc({required this.chatRepository})
      : super(UserFromLocalStorageInitialState());

  @override
  Stream<UserFromLocalStorageState> mapEventToState(
      UserFromLocalStorageEvent event) async* {
    try {
      final user = await this.chatRepository.getUserFromLocalStorage();
      yield UserFromLocalStorageLoadSuccess(user: user);
    } catch (_) {
      yield UserFromLocalStorageLoadFailure();
    }
  }
}
