import 'package:flutter_chat/features/search_user_for_chat/domain/repositories/user_repository.dart';
import 'package:flutter_chat/features/search_user_for_chat/domain/usecases/get_user.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/data/repositories/user_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => UsersBloc(
      userRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetUserByUserName(
      sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  // sl.registerLazySingleton<UserRemoteDataSource>(
  //   () => UserRemoteDataSourceImpl(),
  // );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
