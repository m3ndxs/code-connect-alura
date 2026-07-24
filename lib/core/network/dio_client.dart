import 'package:code_connect_app/core/network/auth_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "http://10.0.2.2:3000",
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {"Accept": "application/json"},
        ),
      ) {
    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        request: true,
        requestHeader: true,
        error: true,
      ),
    );
  }
}
