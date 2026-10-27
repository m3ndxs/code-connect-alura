import 'package:code_connect_app/core/network/api_url.dart';
import 'package:code_connect_app/core/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';

class DioClient {
  final SecureStorageService _secureStorage;

  DioClient(this._secureStorage);

  Dio get instance {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.base,
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}
