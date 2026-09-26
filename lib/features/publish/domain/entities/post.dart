import 'package:equatable/equatable.dart';
import 'author.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String markdown;
  final String imageUrl;
  final int likes;
  final Author author;
  final DateTime? createdAt;

  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.markdown,
    required this.imageUrl,
    required this.likes,
    required this.author,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    markdown,
    imageUrl,
    likes,
    author,
    createdAt,
  ];
}
