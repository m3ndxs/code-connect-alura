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
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXMzcmxscTkwMDAwbzBrd2owZ2F5eTB6IiwiZW1haWwiOiJhbmFAY29kZWNvbm5lY3QuY29tIiwiaWF0IjoxNzg2MTkzMzkwLCJleHAiOjE3ODYyNzk3OTB9.I426A5PfzNQArlGV23vSD076b9To7OlOFQ9sM2byLiE';
          return handler.next(options);
        }),
      ),
    );

    return dio;
  }
}
