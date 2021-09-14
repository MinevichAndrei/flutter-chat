import 'package:equatable/equatable.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitialState extends SendMessageState {}

class SendMessageLoadInProgress extends SendMessageState {}

class SendMessageLoadSuccess extends SendMessageState {
  final Future<void> result;

  const SendMessageLoadSuccess({required this.result});

  @override
  List<Object> get props => [result];
}

class UpdateLastMessageLoadSuccess extends SendMessageState {
  final String message;

  const UpdateLastMessageLoadSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SendMessageLoadFailure extends SendMessageState {}
