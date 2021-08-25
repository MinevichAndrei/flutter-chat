import 'package:equatable/equatable.dart';
import 'package:flutter_chat/core/usecase/usecase.dart';
import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';
import 'package:flutter_chat/features/chat/domain/repositories/user_repository.dart';

class GetUserByUserName extends UseCase<List<UserEntity>, UserParams> {
  final UserRepository userRepository;

  GetUserByUserName(this.userRepository);

  Stream<List<UserEntity>> call(UserParams params) {
    return userRepository.getUserByUserName(params.username);
  }
}

class UserParams extends Equatable {
  final String username;

  UserParams({required this.username});

  @override
  List<Object?> get props => [username];
}
