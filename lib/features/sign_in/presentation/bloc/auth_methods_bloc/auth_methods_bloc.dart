import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_chat/features/sign_in/domain/repositories/user_signin_repository.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_event.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_state.dart';

class AuthMethodsBloc extends Bloc<AuthMethodsEvent, AuthMethodsState> {
  final UserSignInRepository _userSignInRepository;

  AuthMethodsBloc({required UserSignInRepository userSignInRepository})
      : _userSignInRepository = userSignInRepository,
        super(Uninitialized());

  @override
  Stream<AuthMethodsState> mapEventToState(AuthMethodsEvent event) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedEventToState();
    } else if (event is SignUpEvent) {
      yield* _mapSignUpEventToState(event.email, event.password);
    } else if (event is SignInWithGoogleEvent) {
      yield* _mapSignInWithGoogleEventToState();
    } else if (event is AppExitEvent) {
      yield* _mapAppOutedEventToState();
    } else if (event is SignInEvent) {
      yield* _mapSignInEventToState(event.email, event.password);
    }
  }

  Stream<AuthMethodsState> _mapAppStartedEventToState() async* {
    try {
      final isSignedIn = await _userSignInRepository.isAuthenticated();
      yield AuthentificatedState(isSignedIn);
    } catch (_) {
      yield AuthStateError();
    }
  }

  Stream<AuthMethodsState> _mapAppOutedEventToState() async* {
    try {
      final isSignedOut = await _userSignInRepository.signOut();
      if (isSignedOut) yield SignOuted();
    } catch (_) {
      yield UnSignOut();
    }
  }

  Stream<AuthMethodsState> _mapSignUpEventToState(
      String email, String password) async* {
    try {
      final result = await _userSignInRepository.signUpEmail(email, password);
      if (result == "Signed Up") {
        final userId = _userSignInRepository.getUserId();
        yield userId == null
            ? AuthStateError()
            : SignUpWithEmailAndPasswordStateSuccess(userId);
      }
    } catch (e) {
      yield AuthStateError();
    }
  }

  Stream<AuthMethodsState> _mapSignInWithGoogleEventToState() async* {
    try {
      await _userSignInRepository.authenticate();
      final userId = _userSignInRepository.getUserId();
      yield userId == null ? AuthStateError() : AuthentificatedState(true);
    } catch (_) {
      yield AuthStateError();
    }
  }

  Stream<AuthMethodsState> _mapSignInEventToState(
      String email, String password) async* {
    try {
      final result = await _userSignInRepository.signInEmail(email, password);
      if (result == "Signed in") {
        final userId = _userSignInRepository.getUserId();
        yield userId == null ? AuthStateError() : AuthentificatedState(true);
      }
    } catch (e) {
      yield AuthStateError();
    }
  }
}
