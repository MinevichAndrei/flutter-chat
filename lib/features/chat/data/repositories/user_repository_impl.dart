import 'package:flutter_chat/features/chat/data/datasources/user_remote_data_source.dart';

import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/chat/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Stream<List<UserEntity>> getUserByUserName(String username) {
    final remoteUser = userRemoteDataSource.getUser(username);
    return remoteUser;
  }
}
