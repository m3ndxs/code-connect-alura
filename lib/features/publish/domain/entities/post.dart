import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String markdown;
  final String imageUrl;

  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.markdown,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, title, body, markdown, imageUrl];
}
