import 'package:bloc_test/bloc_test.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:code_connect_app/features/profile/domain/usecases/profile_use_case.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProfileUseCase extends Mock implements ProfileUseCase {}

void main() {
  late ProfileBloc bloc;
  late MockGetProfileUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetProfileUseCase();
    bloc = ProfileBloc(profileUseCase: mockUseCase);
  });

  final tUserEntity = UserEntity(
    id: '123',
    email: 'joao@teste.com',
    name: 'João',
    username: 'joao_dev_test',
    avatar: 'avatar_test.png',
  );

  group('Profile Bloc', () {
    blocTest(
      'Deve emitir [ProfileLoading, ProfileSuccess] quando a buscar funcionar',
      build: () {
        when(
          () => mockUseCase(),
        ).thenAnswer((_) async => Right<Failure, UserEntity>(tUserEntity));

        return bloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [ProfileLoading(), ProfileSuccess(tUserEntity)],
    );
  });
}
