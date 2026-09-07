import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ProfileRemoteDataSourceImpl(dio: mockDio);
  });

  final tJsonResponse = {
    'id': '123',
    'email': 'joao@teste.com',
    'name': "João",
    'username': "joao_dev_test",
    'avatar': 'avatar_test.png',
  };

  final tUserModel = UserModel(
    id: '123',
    email: 'joao@teste.com',
    name: 'João',
    username: 'joao_dev_test',
    avatar: 'avatar_test.png',
  );

  group('GetProfile', () {
    test(
      'Deve retornar um UserModel quando a requisição GET for 200 (Success)',
      () async {
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: tJsonResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/auth/me'),
          ),
        );

        final result = await dataSource.getProfile();

        expect(result, equals(tUserModel));
        verify(() => mockDio.get('/auth/me')).called(1);
      },
    );

    test(
      'Deve lançar uma ServerException quando o Dio lançar um DioException',
      () async {
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/me'),
            response: Response(
              statusCode: 401,
              requestOptions: RequestOptions(path: '/auth/me'),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final call = dataSource.getProfile;

        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
