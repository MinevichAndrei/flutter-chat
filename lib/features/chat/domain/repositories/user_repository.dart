import 'package:flutter_chat/features/chat/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<List<UserEntity>> getUserByUserName(String username);
}
