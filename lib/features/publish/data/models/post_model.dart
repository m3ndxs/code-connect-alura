import 'package:code_connect_app/core/network/api_url.dart';
import 'package:code_connect_app/features/publish/data/models/author_model.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.markdown,
    required super.imageUrl,
    required super.likes,
    required super.author,
    required super.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      markdown: json['markdown'] as String? ?? '',
      imageUrl: ApiUrl.resolve(
        (json['imageUrl'] as String?) ?? (json['cover'] as String? ?? ''),
      ),
      likes: json['likes'] ?? 0,
      author: AuthorModel.fromJson(
        json['author'] as Map<String, dynamic>? ?? const {},
      ),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
    );
  }

  static List<PostModel> fromJsonList(List<dynamic> json) =>
      json.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
}
