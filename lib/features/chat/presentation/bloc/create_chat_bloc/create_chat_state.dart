import 'package:equatable/equatable.dart';

abstract class CreateChatState extends Equatable {
  const CreateChatState();

  @override
  List<Object> get props => [];
}

class CreateChatInitialState extends CreateChatState {}

class CreateChatCreateInProgress extends CreateChatState {}

class CreateChatCreateSuccess extends CreateChatState {
  final String result;
  CreateChatCreateSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class CreateChatCreateFailure extends CreateChatState {}
