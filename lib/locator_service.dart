import 'package:flutter_chat/features/search_user_for_chat/data/repositories/user_repository_impl.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/repositories/user_repository.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/data/repositories/user_signin_repository_impl.dart';
import 'package:flutter_chat/features/sign_in_with_google/domain/repositories/user_signin_repository.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => UsersBloc(
      userRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => SignInWithGoogleBloc(
      userSignInRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UsersInfoBloc(
      userRepository: sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton<UserSignInRepository>(
      () => UserSignInRepositoryImpl());

  // sl.registerLazySingleton<UserRemoteDataSource>(
  //   () => UserRemoteDataSourceImpl(),
  // );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
