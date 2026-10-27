import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });
}
