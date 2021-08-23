import 'package:flutter_chat/features/chat/data/repositories/user_repository_impl.dart';
import 'package:flutter_chat/features/chat/domain/usecases/get_user.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/chat/data/datasources/user_remote_data_source.dart';
import 'features/chat/domain/repositories/user_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => UsersListBloc(
      getUser: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetUserByUserName(
      sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
