import 'package:equatable/equatable.dart';

abstract class UserFromLocalStorageEvent extends Equatable {
  const UserFromLocalStorageEvent();

  @override
  List<Object> get props => [];
}

class UserLoadedFromLocalStorage extends UserFromLocalStorageEvent {}
