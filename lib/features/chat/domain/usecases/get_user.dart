import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat/core/error/failure.dart';
import 'package:flutter_chat/core/usecase/usecase.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/chat/domain/repositories/user_repository.dart';

class GetUserByUserName extends UseCase<List<UserEntity>, UserParams> {
  final UserRepository userRepository;

  GetUserByUserName(this.userRepository);

  Future<Either<Failure, List<UserEntity>>> call(UserParams params) async {
    return await userRepository.getUserByUserName(params.username);
  }
}

class UserParams extends Equatable {
  final String username;

  UserParams({required this.username});

  @override
  List<Object?> get props => [username];
}
