import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/register/domain/entities/register_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterResponseEntity>> register({
    required String email,
    required String password,
    required String name,
  });
}
