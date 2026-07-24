import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  String? token;

  AuthInterceptor({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Token $token');

    if (token != null && token!.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }
}
