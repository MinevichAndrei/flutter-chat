import 'package:equatable/equatable.dart';

abstract class SignInWithGoogleEvent extends Equatable {}

class AppStarted extends SignInWithGoogleEvent {
  @override
  List<Object> get props => [];
}

class AppExit extends SignInWithGoogleEvent {
  @override
  List<Object> get props => [];
}
