import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:code_connect_app/features/publish/domain/usecase/get_posts_by_profile_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublishReposity extends Mock implements PublishRepository {}

void main() {
  late GetPostsByProfileUseCase usecase;
  late MockPublishReposity mockRepository;

  setUp(() {
    mockRepository = MockPublishReposity();
    usecase = GetPostsByProfileUseCase(mockRepository);
  });

  const tProfileId = 'clxyz123abc';
  final tPosts = <Post>[];

  group('GetPostsByProfileUseCase', () {
    test('Deve buscar os posts do profile no repositório', () async {
      when(
        () => mockRepository.getPostsByProfile(tProfileId),
      ).thenAnswer((_) async => Right<Failure, List<Post>>(tPosts));

      final result = await usecase(tProfileId);

      expect(result, equals(Right<Failure, List<Post>>(tPosts)));
      verify(() => mockRepository.getPostsByProfile(tProfileId)).called(1);
    });

    test('Deve propagar o erro retornado pelo repositório', () async {
      when(
        () => mockRepository.getPostsByProfile(tProfileId),
      ).thenAnswer(
        (_) async =>
            Left<Failure, List<Post>>(ServerFailure('Erro ao buscar posts')),
      );

      final result = await usecase(tProfileId);

      expect(
        result,
        Left<Failure, List<Post>>(ServerFailure('Erro ao buscar posts')),
      );
    });
  });
}