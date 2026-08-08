import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:code_connect_app/features/profile/domain/usecases/profile_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileReposity extends Mock implements ProfileRepository {}

void main() {
  late ProfileUseCase usecase;
  late MockProfileReposity mockRepository;

  setUp(() {
    mockRepository = MockProfileReposity();
    usecase = ProfileUseCase(mockRepository);
  });

  final tUserEntity = UserEntity(
    id: '123',
    email: 'joao@teste.com',
    name: 'João',
    username: 'joao_dev_test',
    avatar: 'avatar_test.png',
  );

  group('GetProfileUsecase', () {
    test('Deve buscar os dados de perfil no repositório', () async {
      when(
        () => mockRepository.getProfile(),
      ).thenAnswer((_) async => Right(tUserEntity));

      final result = await usecase();

      expect(result, equals(Right<Failure, UserEntity>(tUserEntity)));
      verify(() => mockRepository.getProfile()).called(1);
    });
  });
}
