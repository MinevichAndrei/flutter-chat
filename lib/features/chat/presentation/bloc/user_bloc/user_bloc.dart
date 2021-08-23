import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/error/failure.dart';
import 'package:flutter_chat/features/chat/domain/usecases/get_user.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/users_event.dart';

class UsersListBloc extends Bloc<UsersEvent, UsersState> {
  final GetUserByUserName getUser;
  UsersListBloc({required this.getUser}) : super(UserEmpty());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is GetUsersEvent) {
      yield* _mapFetchOneNewsToState(event.username);
    }
  }

  Stream<UsersState> _mapFetchOneNewsToState(String username) async* {
    yield UsersLoading();

    final failureOrUsers = await getUser(UserParams(username: username));

    yield failureOrUsers.fold(
        (failure) => UsersError(message: _mapFailureToMessage(failure)),
        (item) => UsersLoaded(item));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
