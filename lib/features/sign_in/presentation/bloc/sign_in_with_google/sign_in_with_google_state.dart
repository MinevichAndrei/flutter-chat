import 'package:equatable/equatable.dart';

abstract class SignInWithGoogleState extends Equatable {
  const SignInWithGoogleState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends SignInWithGoogleState {}

class SignInWithGoogleStateSuccess extends SignInWithGoogleState {
  const SignInWithGoogleStateSuccess(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'Authenticated { userId: $userId }';
}

class SignInWithGoogleStateError extends SignInWithGoogleState {}

class SignOuted extends SignInWithGoogleState {}

class UnSignOut extends SignInWithGoogleState {}
