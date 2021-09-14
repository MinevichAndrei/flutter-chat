import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/entities/message_entity.dart';
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
  }

  Stream<ChatRoomMessagesState> _mapChatRoomMessagesEventToState(
      String chatRoomId) async* {
    try {
      final users = this.chatRepository.getChatRoomMessages(chatRoomId);
      List<MessageEntity> listMessages = await users.first;
      yield ChatRoomMessagesLoadSuccess(messages: listMessages);
    } catch (_) {
      yield ChatRoomMessagesLoadFailure();
    }
  }
}
