import 'dart:io';

import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/data/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PublishRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = PublishRemoteDataSourceImpl(dio: mockDio);
  });

  const tProfileId = 'clxyz123abc';

  final tPostJson = <String, dynamic>{
    'id': 1,
    'cover': 'https://example.com/cover.png',
    'imageUrl': '/uploads/image-123.jpg',
    'title': 'Introdução ao React',
    'slug': 'introducao-ao-react',
    'body': 'Neste post, vamos explorar os conceitos básicos do React...',
    'markdown': '```javascript\nfunction HelloComponent() {\n  return <h1>Hello, world!</h1>;\n}\n```',
    'likes': 42,
    'author': <String, dynamic>{
      'id': 'clxyz123abc',
      'name': 'João Silva',
      'username': 'joaosilva_dev',
      'avatar': 'https://example.com/avatar.png',
    },
    'createdAt': '2024-01-01T00:00:00.000Z',
  };

  final tPostModels = <PostModel>[PostModel.fromJson(tPostJson)];
  final tPostModel = PostModel.fromJson(tPostJson);

  group('GetPostsByProfile', () {
    test(
      'Deve retornar lista de PostModel quando o GET for 200 (Success)',
      () async {
        when(
          () => mockDio.get(
            '/blog-posts',
            queryParameters: {'authorId': tProfileId},
          ),
        ).thenAnswer(
          (_) async => Response(
            data: <dynamic>[tPostJson],
            statusCode: 200,
            requestOptions: RequestOptions(path: '/blog-posts'),
          ),
        );

        final result = await dataSource.getPostsByProfile(tProfileId);

        expect(result, equals(tPostModels));
        verify(
          () => mockDio.get(
            '/blog-posts',
            queryParameters: {'authorId': tProfileId},
          ),
        ).called(1);
      },
    );

    test(
      'Deve lançar ServerException quando o GET retornar status diferente de 200',
      () async {
        when(
          () => mockDio.get(
            '/blog-posts',
            queryParameters: {'authorId': tProfileId},
          ),
        ).thenAnswer(
          (_) async => Response(
            data: <String, dynamic>{'message': 'Erro ao buscar posts'},
            statusCode: 500,
            requestOptions: RequestOptions(path: '/blog-posts'),
          ),
        );

        final call = dataSource.getPostsByProfile;

        expect(() => call(tProfileId), throwsA(isA<ServerException>()));
      },
    );

    test(
      'Deve lançar ServerException com a mensagem da resposta quando o Dio '
      'lançar uma DioException',
      () async {
        when(
          () => mockDio.get(
            '/blog-posts',
            queryParameters: {'authorId': tProfileId},
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/blog-posts'),
            response: Response(
              statusCode: 401,
              data: <String, dynamic>{'message': 'Não autorizado'},
              requestOptions: RequestOptions(path: '/blog-posts'),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final call = dataSource.getPostsByProfile;

        expect(
          () => call(tProfileId),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'Não autorizado',
            ),
          ),
        );
      },
    );
  });

  group('PostPublish', () {
    late File tempImage;

    setUpAll(() {
      tempImage = File('${Directory.systemTemp.path}/test_cover.png');
      tempImage.writeAsBytesSync(<int>[0x89, 0x50, 0x4E, 0x47]);
    });

    tearDownAll(() {
      if (tempImage.existsSync()) tempImage.deleteSync();
    });

    test('Deve retornar um PostModel quando o POST for 200/201 (Success)', () async {
      when(() => mockDio.post('/blog-posts', data: any(named: 'data')))
          .thenAnswer(
            (_) async => Response(
              data: tPostJson,
              statusCode: 201,
              requestOptions: RequestOptions(path: '/blog-posts'),
            ),
          );

      final result = await dataSource.postPublish(
        'Introdução ao React',
        'Conteúdo do post',
        '```dart\nvoid main() {}\n```',
        tempImage,
      );

      expect(result, equals(tPostModel));
      verify(() => mockDio.post('/blog-posts', data: any(named: 'data')))
          .called(1);
    });

    test('Deve lançar ServerException quando o POST retornar status != 200/201',
        () async {
      when(() => mockDio.post('/blog-posts', data: any(named: 'data')))
          .thenAnswer(
            (_) async => Response(
              data: <String, dynamic>{'message': 'Dados inválidos'},
              statusCode: 400,
              requestOptions: RequestOptions(path: '/blog-posts'),
            ),
          );

      final call = dataSource.postPublish;

      expect(
        () => call(
          'Introdução ao React',
          'Conteúdo do post',
          '```dart\nvoid main() {}\n```',
          tempImage,
        ),
        throwsA(isA<ServerException>()),
      );
    });

    test(
      'Deve lançar ServerException extraindo a mensagem quando o Dio '
      'lançar uma DioException',
      () async {
        when(() => mockDio.post('/blog-posts', data: any(named: 'data')))
            .thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/blog-posts'),
            response: Response(
              statusCode: 500,
              data: <String, dynamic>{'error': 'Falha interna'},
              requestOptions: RequestOptions(path: '/blog-posts'),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final call = dataSource.postPublish;

        expect(
          () => call(
            'Introdução ao React',
            'Conteúdo do post',
            '```dart\nvoid main() {}\n```',
            tempImage,
          ),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'Falha interna',
            ),
          ),
        );
      },
    );
  });
}
