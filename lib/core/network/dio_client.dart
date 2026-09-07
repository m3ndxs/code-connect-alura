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
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXMzcmxscTkwMDAwbzBrd2owZ2F5eTB6IiwiZW1haWwiOiJhbmFAY29kZWNvbm5lY3QuY29tIiwiaWF0IjoxNzg4Nzg5MzA4LCJleHAiOjE3ODg4NzU3MDh9.Gl0nK2GUXC3Yn3vxMQL0uKSu00C5r6phrpE34rMVJ4E';
          return handler.next(options);
        }),
      ),
    );

    return dio;
  }
}
