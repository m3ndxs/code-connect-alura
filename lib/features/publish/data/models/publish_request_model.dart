import 'dart:io';

import 'package:dio/dio.dart';

class PublishRequestModel {
  final String title;
  final String body;
  final String markdown;
  final File image;

  PublishRequestModel({
    required this.title,
    required this.body,
    required this.markdown,
    required this.image,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap(({
      "title": title,
      "body": body,
      "markdown": markdown,
      "iamge": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    }));
  }
}
