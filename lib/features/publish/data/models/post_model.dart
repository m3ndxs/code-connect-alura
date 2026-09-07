import 'package:code_connect_app/features/publish/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.markdown,
    required super.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      markdown: json['markdown'] as String? ?? '',
      imageUrl: (json['imageUrl'] as String?) ??
          (json['cover'] as String? ?? ''),
    );
  }
}
