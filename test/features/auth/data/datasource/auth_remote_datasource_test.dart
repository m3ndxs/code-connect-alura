import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/auth/data/models/login_response_model.dart';
import 'package:code_connect_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AuthRemoteDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = AuthRemoteDatasourceImpl(mockDio);
  });

  final tLoginResponseModel = LoginResponseModel(
    accessToken: 'tokenteste123',
    user: UserModel(
      id: '213421',
      email: 'teste@email.com',
      name: 'Fulano Ciclano',
    ),
  );

  group('Login', () {
    test(
      'should return LoginResponseModel when request for 200 (Success)',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 200,
            data: {
              'access_token': 'tokenteste123',
              'user': {
                'id': '213421',
                'email': 'teste@email.com',
                'name': 'Fulano Ciclano',
              },
            },
          ),
        );

        final result = await datasource.login(
          email: 'teste@email.com',
          password: '12345678',
        );

        expect(result, tLoginResponseModel);
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '/auth/login',
            data: {'email': 'teste@email.com', 'password': '12345678'},
          ),
        ).called(1);
      },
    );

    test(
      'should return ServerException when POST return different status for 200',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: <String, dynamic>{'message': 'erro no servidor'},
            statusCode: 500,
            requestOptions: RequestOptions(path: '/auth/login'),
          ),
        );

        final call = datasource.login;

        expect(
          () => call(email: 'teste@email.com', password: '12345678'),
          throwsA(isA<ServerException>()),
        );
      },
    );

    test(
      'should return ServerException when Dio to throw DioException',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/login'),
            response: Response(
              statusCode: 401,
              requestOptions: RequestOptions(path: '/auth/login'),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final call = datasource.login;

        expect(
          () => call(email: 'teste@email.com', password: '12345678'),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'Servidor Indisponível no momento.',
            ),
          ),
        );
      },
    );
  });
}
