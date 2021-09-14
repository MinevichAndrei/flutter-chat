import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SearchUser extends UserEvent {
  final String user;

  const SearchUser(this.user);

  @override
  List<Object> get props => [user];
}
