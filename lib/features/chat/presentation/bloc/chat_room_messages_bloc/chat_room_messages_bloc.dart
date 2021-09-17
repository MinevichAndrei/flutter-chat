import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_state.dart';

class ChatRoomMessagesBloc
    extends Bloc<ChatRoomMessagesEvent, ChatRoomMessagesState> {
  final ChatRepository chatRepository;

  ChatRoomMessagesBloc({required this.chatRepository})
      : super(ChatRoomMessagesInitialState());

  @override
  Stream<ChatRoomMessagesState> mapEventToState(
      ChatRoomMessagesEvent event) async* {
    if (event is LoadMessages) {
      yield* _mapChatRoomMessagesEventToState(event.chatRoomId);
    }
    if (event is ReceiveEvent) {
      yield ChatRoomMessagesLoadSuccess(messages: event.messages);
    }
  }

  Stream<ChatRoomMessagesState> _mapChatRoomMessagesEventToState(
      String chatRoomId) async* {
    try {
      final users = this.chatRepository.getChatRoomMessages(chatRoomId);
      users.listen((ms) => add(ReceiveEvent(ms)));
    } catch (_) {
      yield ChatRoomMessagesLoadFailure();
    }
  }
}
