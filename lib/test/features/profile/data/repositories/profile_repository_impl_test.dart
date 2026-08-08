import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/data/models/user_model.dart';
import 'package:code_connect_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileDataSource extends Mock implements ProfileRemoteDataSource {}

void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockProfileDataSource();
    repository = ProfileRepositoryImpl(datasource: mockDataSource);
  });

  final tUserModel = UserModel(
    id: '123',
    email: 'joao@teste.com',
    name: 'João',
    username: 'joao_dev_test',
    avatar: 'avatar_test.png',
  );

  final tUserEntity = UserEntity(
    id: '123',
    email: 'joao@teste.com',
    name: 'João',
    username: 'joao_dev_test',
    avatar: 'avatar_test.png',
  );

  group('ProfileRepositoryImpl', () {
    test(
      'Deve retornar Right(ProfileEntity) quando o DataSource for bem-sucedido',
      () async {
        when(
          () => mockDataSource.getProfile(),
        ).thenAnswer((_) async => tUserModel);

        final result = await repository.getProfile();

        expect(result, equals(Right<Failure, UserEntity>(tUserModel)));
        verify(() => mockDataSource.getProfile()).called(1);
      },
    );

    test(
      'Deve retornar Left(ServerFailure) quando o DataSource lançar ServerException',
      () async {
        when(() => mockDataSource.getProfile()).thenThrow(ServerException());

        final result = await repository.getProfile();

        expect(result, Left(ServerFailure('Servidor Indisponível no momento')));
      },
    );
  });
}
