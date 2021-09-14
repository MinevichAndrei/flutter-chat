import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_chat/features/sign_in/domain/repositories/user_signin_repository.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_event.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_state.dart';

class SignInWithGoogleBloc
    extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  final UserSignInRepository _userSignInRepository;

  SignInWithGoogleBloc({required UserSignInRepository userSignInRepository})
      : _userSignInRepository = userSignInRepository,
        super(Uninitialized());

  @override
  Stream<SignInWithGoogleState> mapEventToState(
      SignInWithGoogleEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AppExit) {
      yield* _mapAppOutedToState();
    }
  }

  Stream<SignInWithGoogleState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userSignInRepository.isAuthenticated();
      if (!isSignedIn) await _userSignInRepository.authenticate();
      final userId = _userSignInRepository.getUserId();
      yield userId == null
          ? SignInWithGoogleStateError()
          : SignInWithGoogleStateSuccess(userId);
    } catch (_) {
      yield SignInWithGoogleStateError();
    }
  }

  Stream<SignInWithGoogleState> _mapAppOutedToState() async* {
    try {
      final isSignedOut = await _userSignInRepository.signOut();
      if (isSignedOut) yield SignOuted();
    } catch (_) {
      yield UnSignOut();
    }
  }
}
