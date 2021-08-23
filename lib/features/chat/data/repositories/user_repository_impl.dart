import 'package:flutter_chat/core/error/exception.dart';
import 'package:flutter_chat/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_chat/features/chat/data/datasources/user_remote_data_source.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/chat/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUserByUserName(
      String username) async {
    try {
      final remoteUser = await userRemoteDataSource.getUser(username);
      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
