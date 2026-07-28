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
    dio.interceptors.add(
      AuthInterceptor(
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXMzcmxscTkwMDAwbzBrd2owZ2F5eTB6IiwiZW1haWwiOiJhbmFAY29kZWNvbm5lY3QuY29tIiwiaWF0IjoxNzg1MTg5MzQ3LCJleHAiOjE3ODUyNzU3NDd9.xRwePh1Lqe3-gi5F4qoKaZfJtaIEP7Ka-PMBR3f5J6I',
      ),
    );

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
