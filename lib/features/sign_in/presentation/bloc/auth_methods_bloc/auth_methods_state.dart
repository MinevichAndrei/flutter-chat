import 'package:equatable/equatable.dart';

abstract class AuthMethodsState extends Equatable {
  const AuthMethodsState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthMethodsState {}

class SignOuted extends AuthMethodsState {}

class UnSignOut extends AuthMethodsState {}

class AuthentificatedState extends AuthMethodsState {
  final bool isAuth;

  const AuthentificatedState(this.isAuth);

  @override
  List<Object> get props => [isAuth];
}

class AuthStateError extends AuthMethodsState {}

// Sign Up with Email and Password

class SignUpWithEmailAndPasswordStateSuccess extends AuthMethodsState {
  const SignUpWithEmailAndPasswordStateSuccess(this.userId);
  final String userId;
  @override
  List<Object> get props => [userId];
}
