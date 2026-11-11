import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/register/data/datasource/register_remote_datasource.dart';
import 'package:code_connect_app/features/register/data/models/register_entity_model.dart';
import 'package:code_connect_app/features/register/data/models/register_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late RegisterRemoteDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = RegisterRemoteDatasourceImpl(mockDio);
  });

  final tRegisterResponseModel = RegisterResponseModel(
    accessToken: 'tokenteste123',
    user: RegisterEntityModel(
      id: '213421',
      email: 'teste@email.com',
      name: 'Fulano Ciclano',
    ),
  );

  final tJsonResponse = <String, dynamic>{
    'access_token': 'tokenteste123',
    'user': <String, dynamic>{
      'id': '213421',
      'email': 'teste@email.com',
      'name': 'Fulano Ciclano',
    },
  };

  group('Register', () {
    test(
      'should return RegisterResponseModel when POST returns 201 (Success)',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 201,
            data: tJsonResponse,
          ),
        );

        final result = await datasource.register(
          email: 'teste@email.com',
          password: '12345678',
          name: 'Fulano Ciclano',
        );

        expect(result, tRegisterResponseModel);
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '/auth/register',
            data: {
              'email': 'teste@email.com',
              'password': '12345678',
              'name': 'Fulano Ciclano',
            },
          ),
        ).called(1);
      },
    );

    test(
      'should return RegisterResponseModel when POST returns 200 (Success)',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 200,
            data: tJsonResponse,
          ),
        );

        final result = await datasource.register(
          email: 'teste@email.com',
          password: '12345678',
          name: 'Fulano Ciclano',
        );

        expect(result, tRegisterResponseModel);
      },
    );

    test(
      'should throw ServerException with response message when POST returns '
      'status other than 200/201',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 400,
            data: <String, dynamic>{'message': 'Erro ao registrar usuário'},
          ),
        );

        final call = datasource.register;

        expect(
          () => call(
            email: 'teste@email.com',
            password: '12345678',
            name: 'Fulano Ciclano',
          ),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'Erro ao registrar usuário',
            ),
          ),
        );
      },
    );

    test(
      'should throw ServerException with response message when Dio throws '
      'DioException',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/auth/register'),
            response: Response(
              statusCode: 409,
              data: <String, dynamic>{'error': 'E-mail já cadastrado'},
              requestOptions: RequestOptions(path: '/auth/register'),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final call = datasource.register;

        expect(
          () => call(
            email: 'teste@email.com',
            password: '12345678',
            name: 'Fulano Ciclano',
          ),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'E-mail já cadastrado',
            ),
          ),
        );
      },
    );

    test(
      'should throw ServerException joining messages when response returns '
      'a list of errors',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 400,
            data: <String, dynamic>{
              'message': <String>[
                'email must be an email',
                'password too short',
              ],
            },
          ),
        );

        final call = datasource.register;

        expect(
          () => call(
            email: 'teste@email.com',
            password: '12345678',
            name: 'Fulano Ciclano',
          ),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'email must be an email\npassword too short',
            ),
          ),
        );
      },
    );

    test(
      'should throw ServerException with default message when response has '
      'no message',
      () async {
        when(
          () => mockDio.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/register'),
            statusCode: 500,
            data: <String, dynamic>{},
          ),
        );

        final call = datasource.register;

        expect(
          () => call(
            email: 'teste@email.com',
            password: '12345678',
            name: 'Fulano Ciclano',
          ),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'Servidor Indisponível no momento',
            ),
          ),
        );
      },
    );
  });
}
