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
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXMzcmxscWowMDAzbzBrd3A4dzdzbjNsIiwiZW1haWwiOiJkaWVnb0Bjb2RlY29ubmVjdC5jb20iLCJpYXQiOjE3ODk1OTcxNzcsImV4cCI6MTc4OTY4MzU3N30.ECI05WLXNSLJ8HLje-vQLndcaTyF3WncVrJoA7zxaIc';
          return handler.next(options);
        }),
      ),
    );

    return dio;
  }
}
