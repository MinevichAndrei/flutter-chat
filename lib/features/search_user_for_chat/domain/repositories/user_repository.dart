import 'package:flutter_chat/features/search_user_for_chat/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<List<UserEntity>> users(String username);
  //UserEntity userInfo(String username);
}
