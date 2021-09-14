import 'dart:async';

import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersInfoBloc extends Bloc<UsersInfoEvent, UsersInfoState> {
  final ChatRepository chatRepository;

  UsersInfoBloc({required this.chatRepository})
      : super(UsersInfoLoadInProgress());

  @override
  Stream<UsersInfoState> mapEventToState(UsersInfoEvent event) async* {
    if (event is UsersInfoLoaded) {
      try {
        final user = await this.chatRepository.getUserInfo(event.user);
        yield UsersInfoLoadSuccess(user: user);
      } catch (_) {
        yield UsersInfoLoadFailure();
      }
    }
  }
}
