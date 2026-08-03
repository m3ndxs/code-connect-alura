import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource datasource;

  ProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final user = await datasource.getProfile();
      return Right(user);
    } on ServerException {
      return const Left(ServerFailure('Servidor Indisponível no momento'));
    }
  }
}
