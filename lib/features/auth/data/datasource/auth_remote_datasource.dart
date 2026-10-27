import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponseModel.fromJson(response.data!);
      } else {
        throw ServerException(_extractMessage(response.data));
      }
    } on DioException catch (error) {
      throw ServerException(_extractMessage(error.response?.data));
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];

      if (message is String && message.isNotEmpty) return message;

      if (message is List && message.isNotEmpty) {
        return message.map((e) => e.toString()).join('\n');
      }
    }
    return 'Servidor Indisponível no momento.';
  }
}
