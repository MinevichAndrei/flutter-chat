import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/domain/repositories/user_signin_repository.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_state.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_event.dart';

class SignInWithGoogleBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserSignInRepository _userSignInRepository;

  SignInWithGoogleBloc({required UserSignInRepository userSignInRepository})
      : _userSignInRepository = userSignInRepository,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AppExit) {
      yield* _mapAppOutedToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userSignInRepository.isAuthenticated();
      if (!isSignedIn) await _userSignInRepository.authenticate();
      final userId = _userSignInRepository.getUserId();
      yield userId == null ? Unauthenticated() : Authenticated(userId);
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAppOutedToState() async* {
    try {
      final isSignedOut = await _userSignInRepository.signOut();
      if (isSignedOut) yield SignOuted();
    } catch (_) {
      yield UnSignOut();
    }
  }
}
