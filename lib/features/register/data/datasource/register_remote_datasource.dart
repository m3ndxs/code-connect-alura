import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/register/data/models/register_response_model.dart';
import 'package:code_connect_app/features/register/domain/entities/register_response_entity.dart';
import 'package:dio/dio.dart';

abstract class RegisterRemoteDatasource {
  Future<RegisterResponseEntity> register({
    required String email,
    required String password,
    required String name,
  });
}

class RegisterRemoteDatasourceImpl implements RegisterRemoteDatasource {
  final Dio dio;

  RegisterRemoteDatasourceImpl(this.dio);

  @override
  Future<RegisterResponseEntity> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/register',
        data: {'email': email, 'password': password, 'name': name},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data!);
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
        return message.map((e) => e.toString()).join(('\n'));
      }
    }

    return 'Servidor Indisponível no momento';
  }
}
