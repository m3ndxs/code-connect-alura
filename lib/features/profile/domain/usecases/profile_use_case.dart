import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileUseCase {
  final ProfileRepository repository;
  ProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getProfile();
  }
}
