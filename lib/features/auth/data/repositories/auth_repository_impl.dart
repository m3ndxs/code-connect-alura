import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/core/storage/secure_storage_service.dart';
import 'package:code_connect_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:code_connect_app/features/auth/domain/entities/auth_entity.dart';
import 'package:code_connect_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource datasource;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl({required this.datasource, required this.secureStorage});

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await datasource.login(email: email, password: password);

      final session = AuthEntity(
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
