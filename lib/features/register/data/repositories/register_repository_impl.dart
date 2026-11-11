import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/core/storage/secure_storage_service.dart';
import 'package:code_connect_app/features/register/data/datasource/register_remote_datasource.dart';
import 'package:code_connect_app/features/register/domain/entities/register_response_entity.dart';
import 'package:code_connect_app/features/register/domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterRemoteDatasource datasource;
  final SecureStorageService secureStorage;

  RegisterRepositoryImpl({
    required this.datasource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, RegisterResponseEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await datasource.register(
        email: email,
        password: password,
        name: name,
      );

      final session = RegisterResponseEntity(
        accessToken: response.accessToken,
        user: response.user,
      );

      await secureStorage.saveAccessToken(session.accessToken);

      return Right(session);
    } on ServerException {
      return const Left(ServerFailure('Servidor Indisponível no momento'));
    }
  }
}
