import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatRepository userRepository;

  ChatsBloc({required this.userRepository}) : super(ChatsInitialState());

  @override
  Stream<ChatsState> mapEventToState(ChatsEvent event) async* {
    if (event is AllChatsLoaded) {
      yield* _mapAllChatsLoadedToState(event.userName);
    }
    if (event is ReceiveEvent) {
      yield ChatsLoadSuccess(chats: event.chats);
    }
  }

  Stream<ChatsState> _mapAllChatsLoadedToState(String userName) async* {
    try {
      final chats = this.userRepository.getChatRooms(userName);
      chats.listen((ch) => add(ReceiveEvent(ch)));
    } catch (e) {
      yield ChatsLoadFailure(message: e.toString());
    }
  }
}
