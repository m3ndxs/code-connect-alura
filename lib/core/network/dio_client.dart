import 'package:code_connect_app/core/network/api_url.dart';
import 'package:dio/dio.dart';

class DioClient {
  static Dio get instance {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.base,
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: ((options, handler) async {
          // O token que esta sendo commitado é um token em HML para testes.
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjbXMzcmxscWowMDAzbzBrd3A4dzdzbjNsIiwiZW1haWwiOiJkaWVnb0Bjb2RlY29ubmVjdC5jb20iLCJpYXQiOjE3OTA0MjcwNDgsImV4cCI6MTc5MDUxMzQ0OH0.xU8J-VfmbEuhhii8deh_v6VGDRvZOrBzjmmNpznvd68';
          return handler.next(options);
        }),
      ),
    );

    return dio;
  }
}
