import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/auth/domain/entities/auth_entity.dart';
import 'package:code_connect_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:code_connect_app/features/auth/domain/usecase/login_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUseCase(mockRepository);
  });

  final tEntity = AuthEntity(
    accessToken:
        'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiZW1haWwiOiJqb2huLmRvZUBleGFtcGxlLmNvbSIsInJvbGVzIjpbImFkbWluIiwidXNlciJdLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MjUzNDA2NDAwMH0',
    user: UserEntity(
      id: 'ajbf1241',
      email: 'teste@email.com',
      name: 'Fulano Ciclano',
    ),
  );

  group('LoginUseCase', () {
    test('should return AuthEntity when repository succeeds', () async {
      when(
        () => mockRepository.login(
          email: 'teste@email.com',
          password: 'senhafraca',
        ),
      ).thenAnswer((_) async => Right(tEntity));

      final result = await usecase(
        email: 'teste@email.com',
        password: 'senhafraca',
      );

      expect(result, Right(tEntity));
      verify(
        () => mockRepository.login(
          email: 'teste@email.com',
          password: 'senhafraca',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      final tFailure = ServerFailure('erro no servidor');

      when(
        () => mockRepository.login(
          email: 'teste@email.com',
          password: 'senhafraca',
        ),
      ).thenAnswer((_) async => Left(tFailure));

      final result = await usecase(
        email: 'teste@email.com',
        password: 'senhafraca',
      );

      expect(result, Left(tFailure));
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'erro no servidor');
      }, (_) => fail('Expected Left, got Right'));

      verify(
        () => mockRepository.login(
          email: 'teste@email.com',
          password: 'senhafraca',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
