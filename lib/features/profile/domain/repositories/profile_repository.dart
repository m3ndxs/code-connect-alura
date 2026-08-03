import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getProfile();
}
