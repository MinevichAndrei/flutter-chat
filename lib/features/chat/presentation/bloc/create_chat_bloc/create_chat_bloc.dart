import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/create_chat_bloc/create_chat_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/create_chat_bloc/create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  final ChatRepository chatRepository;

  CreateChatBloc({required this.chatRepository})
      : super(CreateChatInitialState());

  @override
  Stream<CreateChatState> mapEventToState(CreateChatEvent event) async* {
    if (event is CreateChat) {
      yield* _mapCreateChatEventToState(
          event.chatRoomId, event.chatRoomInfoMap);
    }
  }

  Stream<CreateChatState> _mapCreateChatEventToState(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async* {
    try {
      final result =
          this.chatRepository.createChatRoom(chatRoomId, chatRoomInfoMap);
      yield CreateChatCreateSuccess(result.toString());
    } catch (_) {
      yield CreateChatCreateFailure();
    }
  }
}
