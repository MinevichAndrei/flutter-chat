import 'package:flutter_chat/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:flutter_chat/features/sign_in/data/repositories/user_signin_repository_impl.dart';
import 'package:flutter_chat/features/sign_in/domain/repositories/user_signin_repository.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => SearchUserBloc(
      chatRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => UserFromLocalStorageBloc(
      chatRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => SignInWithGoogleBloc(
      userSignInRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UsersInfoBloc(
      chatRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ChatsBloc(
      userRepository: sl(),
    ),
  );

  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());
  sl.registerLazySingleton<UserSignInRepository>(
      () => UserSignInRepositoryImpl());

  // sl.registerLazySingleton<UserRemoteDataSource>(
  //   () => UserRemoteDataSourceImpl(),
  // );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
