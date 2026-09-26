import 'package:bloc_test/bloc_test.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/domain/entities/author.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/usecase/get_posts_by_profile_use_case.dart';
import 'package:code_connect_app/features/publish/domain/usecase/post_publish_use_case.dart';
import 'package:code_connect_app/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostPublishUseCase extends Mock implements PostPublishUseCase {}

class MockGetPostsByProfileUseCase extends Mock
    implements GetPostsByProfileUseCase {}

void main() {
  late MockGetPostsByProfileUseCase mockGetPostsUseCase;

  setUp(() {
    mockGetPostsUseCase = MockGetPostsByProfileUseCase();
  });

  const tProfileId = 'clxyz123abc';

  final tPost = Post(
    id: 1,
    title: 'Introdução ao React',
    body: 'Neste post, vamos explorar os conceitos básicos do React...',
    markdown: '```javascript\nfunction HelloComponent() {\n  return <h1>Hello, world!</h1>;\n}\n```',
    imageUrl: '/uploads/image-123.jpg',
    likes: 42,
    author: const Author(
      id: 'clxyz123abc',
      name: 'João Silva',
      username: 'joaosilva_dev',
      avatar: 'https://example.com/avatar.png',
    ),
    createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
  );

  final tPosts = <Post>[tPost];

  group('PublishBloc - GetPostsByProfile', () {
    blocTest(
      'Deve emitir [loading, success] com os posts quando a busca funcionar',
      build: () {
        when(
          () => mockGetPostsUseCase(tProfileId),
        ).thenAnswer((_) async => Right<Failure, List<Post>>(tPosts));

        return PublishBloc(
          postPublishUseCase: MockPostPublishUseCase(),
          getPostsByProfileUseCase: mockGetPostsUseCase,
        );
      },
      act: (bloc) => bloc.add(GetPostsByProfileEvent(tProfileId)),
      expect: () => [
        const PublishState(postsStatus: PostsStatus.loading),
        PublishState(posts: tPosts, postsStatus: PostsStatus.success),
      ],
      verify: (_) {
        verify(() => mockGetPostsUseCase(tProfileId)).called(1);
      },
    );

    blocTest(
      'Deve emitir [loading, failure] com a mensagem de erro quando a busca '
      'falhar',
      build: () {
        when(
          () => mockGetPostsUseCase(tProfileId),
        ).thenAnswer(
          (_) async =>
              Left<Failure, List<Post>>(ServerFailure('Erro ao buscar posts')),
        );

        return PublishBloc(
          postPublishUseCase: MockPostPublishUseCase(),
          getPostsByProfileUseCase: mockGetPostsUseCase,
        );
      },
      act: (bloc) => bloc.add(GetPostsByProfileEvent(tProfileId)),
      expect: () => [
        const PublishState(postsStatus: PostsStatus.loading),
        const PublishState(
          postsStatus: PostsStatus.failure,
          postsErrorMessage: 'Erro ao buscar posts',
        ),
      ],
      verify: (_) {
        verify(() => mockGetPostsUseCase(tProfileId)).called(1);
      },
    );
  });
}