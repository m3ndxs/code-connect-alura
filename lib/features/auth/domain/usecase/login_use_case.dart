import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/auth/domain/entities/auth_entity.dart';
import 'package:code_connect_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
