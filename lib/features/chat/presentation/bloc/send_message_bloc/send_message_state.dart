import 'package:equatable/equatable.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitialState extends SendMessageState {}

class SendMessageLoadInProgress extends SendMessageState {}

class SendMessageLoadSuccess extends SendMessageState {}

class UpdateLastMessageLoadSuccess extends SendMessageState {}

class SendMessageLoadFailure extends SendMessageState {}
