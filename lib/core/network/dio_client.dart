import 'package:dio/dio.dart';

class DioClient {
  static Dio get instance {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:3000',
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: ((options, handler) async {
          // O token que esta sendo commitado é um token em HML para testes.
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXMzcmxscWQwMDAxbzBrd3VseWkxMXR3IiwiZW1haWwiOiJicnVub0Bjb2RlY29ubmVjdC5jb20iLCJpYXQiOjE3ODkyMjA4NTgsImV4cCI6MTc4OTMwNzI1OH0.IzCFnMtOM2Y3-m5WQo1G35v5M2s0R3jA6ZCP3mxrnwE';
          return handler.next(options);
        }),
      ),
    );

    return dio;
  }
}
