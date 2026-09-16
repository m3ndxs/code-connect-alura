import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/profile/domain/profile/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile();
}
