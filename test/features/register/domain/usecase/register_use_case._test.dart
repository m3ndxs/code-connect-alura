import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/register/domain/entities/register_entity.dart';
import 'package:code_connect_app/features/register/domain/entities/register_response_entity.dart';
import 'package:code_connect_app/features/register/domain/repositories/register_repository.dart';
import 'package:code_connect_app/features/register/domain/usecase/register_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late RegisterUseCase usecase;
  late MockRegisterRepository mockRepository;

  setUp(() {
    mockRepository = MockRegisterRepository();
    usecase = RegisterUseCase(mockRepository);
  });

  const tRegisterResponseEntity = RegisterResponseEntity(
    accessToken: 'TOKEN_ACESSO',
    user: RegisterEntity(id: '123456', email: 'teste@teste.com', name: 'Teste'),
  );

  final tParams = ParamsRegister(
    email: 'teste@teste.com',
    password: '123456',
    name: 'Teste',
  );

  group('RegisterUseCase', () {
    test(
      'should return RegisterResponseEntity when repository succeeds',
      () async {
        when(
          () => mockRepository.register(
            email: tParams.email,
            password: tParams.password,
            name: tParams.name,
          ),
        ).thenAnswer((_) async => Right(tRegisterResponseEntity));

        final result = await usecase(tParams);

        expect(result, Right(tRegisterResponseEntity));

        verify(
          () => mockRepository.register(
            email: tParams.email,
            password: tParams.password,
            name: tParams.name,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return failure when repository fails', () async {
      final tFailure = ServerFailure('erro no servidor');

      when(
        () => mockRepository.register(
          email: tParams.email,
          password: tParams.password,
          name: tParams.name,
        ),
      ).thenAnswer((_) async => Left(tFailure));

      final result = await usecase(tParams);

      expect(result, Left(tFailure));
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'erro no servidor');
      }, (_) => fail('Expected Left, got Right'));

      verify(
        () => mockRepository.register(
          email: tParams.email,
          password: tParams.password,
          name: tParams.name,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
