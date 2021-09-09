import 'package:flutter_chat/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<List<UserEntity>> users(String username);
  //UserEntity userInfo(String username);
}
