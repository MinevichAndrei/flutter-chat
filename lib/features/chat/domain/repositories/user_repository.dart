import 'package:dartz/dartz.dart';
import 'package:flutter_chat/core/error/failure.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUserByUserName(String username);
}
