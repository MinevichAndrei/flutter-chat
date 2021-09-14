import 'package:equatable/equatable.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class AllChatsLoaded extends ChatsEvent {
  final String userName;

  const AllChatsLoaded(this.userName);

  @override
  List<Object> get props => [userName];
}
