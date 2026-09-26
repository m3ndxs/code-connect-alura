import 'dart:io';

import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/data/models/author_model.dart';
import 'package:code_connect_app/features/publish/data/models/post_model.dart';
import 'package:code_connect_app/features/publish/data/repositories/publish_repository_impl.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublishDataSource extends Mock implements PublishRemoteDataSource {}

void main() {
  late PublishRepositoryImpl repository;
  late MockPublishDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPublishDataSource();
    repository = PublishRepositoryImpl(remoteDataSource: mockDataSource);
  });

  setUpAll(() {
    registerFallbackValue(File('mock_image.png'));
  });

  const tProfileId = 'clxyz123abc';

  final tPostModels = <PostModel>[
    PostModel(
      id: 1,
      title: 'Introdução ao React',
      body: 'Neste post, vamos explorar os conceitos básicos do React...',
      markdown: '```javascript\nfunction HelloComponent() {\n  return <h1>Hello, world!</h1>;\n}\n```',
      imageUrl: '/uploads/image-123.jpg',
      likes: 42,
      author: const AuthorModel(
        id: 'clxyz123abc',
        name: 'João Silva',
        username: 'joaosilva_dev',
        avatar: 'https://example.com/avatar.png',
      ),
      createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
    ),
  ];

  final tPostModel = tPostModels.first;

  group('PublishRepositoryImpl.getPostsByProfile', () {
    test(
      'Deve retornar Right com uma lista de posts quando o DataSource '
      'for bem-sucedido',
      () async {
        when(
          () => mockDataSource.getPostsByProfile(tProfileId),
        ).thenAnswer((_) async => tPostModels);

        final result = await repository.getPostsByProfile(tProfileId);

        expect(result, equals(Right<Failure, List<Post>>(tPostModels)));
        verify(() => mockDataSource.getPostsByProfile(tProfileId)).called(1);
      },
    );

    test(
      'Deve retornar Left(ServerFailure) com a mensagem da exceção quando o '
      'DataSource lançar ServerException',
      () async {
        when(
          () => mockDataSource.getPostsByProfile(tProfileId),
        ).thenThrow(const ServerException('Erro ao buscar posts'));

        final result = await repository.getPostsByProfile(tProfileId);

        expect(
          result,
          Left<Failure, List<Post>>(ServerFailure('Erro ao buscar posts')),
        );
      },
    );
  });

  group('PublishRepositoryImpl.postPublish', () {
    const tTitle = 'Introdução ao React';
    const tBody = 'Neste post, vamos explorar os conceitos básicos do React...';
    const tMarkdown = '```javascript\nfunction HelloComponent() {}\n```';
    final tImage = File('${Directory.systemTemp.path}/test_cover.png');

    test('Deve retornar Right(Post) quando o DataSource for bem-sucedido',
        () async {
      when(
        () => mockDataSource.postPublish(tTitle, tBody, tMarkdown, any()),
      ).thenAnswer((_) async => tPostModel);

      final result = await repository.postPublish(
        tTitle,
        tBody,
        tMarkdown,
        tImage,
      );

      expect(result, equals(Right<Failure, Post>(tPostModel)));
      verify(
        () => mockDataSource.postPublish(tTitle, tBody, tMarkdown, any()),
      ).called(1);
    });

    test(
      'Deve retornar Left(ServerFailure) com a mensagem da exceção quando o '
      'DataSource lançar ServerException',
      () async {
        when(
          () => mockDataSource.postPublish(tTitle, tBody, tMarkdown, any()),
        ).thenThrow(const ServerException('Falha ao publicar'));

        final result = await repository.postPublish(
          tTitle,
          tBody,
          tMarkdown,
          tImage,
        );

        expect(
          result,
          Left<Failure, Post>(ServerFailure('Falha ao publicar')),
        );
      },
    );
  });
}
