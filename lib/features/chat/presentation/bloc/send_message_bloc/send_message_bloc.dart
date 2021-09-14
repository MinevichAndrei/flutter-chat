import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/send_message_bloc/send_message_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/send_message_bloc/send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final ChatRepository chatRepository;

  SendMessageBloc({required this.chatRepository})
      : super(SendMessageInitialState());

  @override
  Stream<SendMessageState> mapEventToState(SendMessageEvent event) async* {
    if (event is SendMessage) {
      yield* _mapChatRoomMessagesEventToState(
          event.chatRoomId, event.messageId, event.messageInfoMap);
    } else if (event is UpdateLastMessage) {
      yield* _mapUpdateLastMessageToState(
          event.chatRoomId, event.lastMessageInfoMap);
    }
  }

  Stream<SendMessageState> _mapChatRoomMessagesEventToState(String chatRoomId,
      String messageId, Map<String, dynamic> messageInfoMap) async* {
    try {
      final result =
          this.chatRepository.addMessage(chatRoomId, messageId, messageInfoMap);
      yield SendMessageLoadSuccess(result: result);
    } catch (_) {
      yield SendMessageLoadFailure();
    }
  }

  Stream<SendMessageState> _mapUpdateLastMessageToState(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) async* {
    try {
      final result = this
          .chatRepository
          .updateLastMessageSend(chatRoomId, lastMessageInfoMap);
      yield UpdateLastMessageLoadSuccess(message: result.toString());
    } catch (_) {
      yield SendMessageLoadFailure();
    }
  }
}
