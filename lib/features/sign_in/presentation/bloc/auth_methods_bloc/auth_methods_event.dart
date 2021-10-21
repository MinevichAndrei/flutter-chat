import 'package:equatable/equatable.dart';

abstract class AuthMethodsEvent extends Equatable {}

class AppStartedEvent extends AuthMethodsEvent {
  @override
  List<Object> get props => [];
}

class AppExitEvent extends AuthMethodsEvent {
  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends AuthMethodsEvent {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthMethodsEvent {
  final String email, password;
  SignUpEvent({required this.email, required this.password});
  @override
  List<Object> get props => [];
}
