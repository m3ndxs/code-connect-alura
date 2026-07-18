import 'package:code_connect_app/features/publish/domain/entities/post.dart';

class PublishResponseModel {
  final int id;
  final String title;
  final String body;
  final String markdown;
  final String imageUrl;

  PublishResponseModel({
    required this.id,
    required this.title,
    required this.body,
    required this.markdown,
    required this.imageUrl,
  });

  // Transformar JSON em objeto
  factory PublishResponseModel.fromJson(Map<String, dynamic> json) {
    return PublishResponseModel(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      markdown: json["markdown"],
      imageUrl: json["imageUrl"],
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      title: title,
      body: body,
      markdown: markdown,
      imageUrl: imageUrl,
    );
  }
}
