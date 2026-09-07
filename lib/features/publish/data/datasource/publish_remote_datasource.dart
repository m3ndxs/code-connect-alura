import 'dart:io';
import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/features/publish/data/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class PublishRemoteDataSource {
  Future<PostModel> postPublish(
    String title,
    String body,
    String markdwon,
    File image,
  );
}

class PublishRemoteDataSourceImpl implements PublishRemoteDataSource {
  final Dio dio;
  PublishRemoteDataSourceImpl({required this.dio});

  @override
  Future<PostModel> postPublish(
    String title,
    String body,
    String markdwon,
    File image,
  ) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'body': body,
        'markdown': markdwon,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.uri.pathSegments.isNotEmpty
              ? image.uri.pathSegments.last
              : 'image.jpg',
          contentType: _contentTypeFor(image.path),
        ),
      });

      final response = await dio.post(
        '/blog-posts',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostModel.fromJson(response.data);
      } else {
        throw ServerException(_extractMessage(response.data));
      }
    } on DioException catch (error) {
      throw ServerException(_extractMessage(error.response?.data));
    }
  }

  MediaType? _contentTypeFor(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'webp':
        return MediaType('image', 'webp');
      case 'gif':
        return MediaType('image', 'gif');
      default:
        return MediaType('image', 'jpeg');
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String && message.isNotEmpty) return message;
    }
    return 'Servidor Indisponível no momento.';
  }
}
