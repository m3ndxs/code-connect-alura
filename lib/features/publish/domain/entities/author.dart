import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String id;
  final String name;
  final String username;
  final String avatar;

  const Author({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
  });

  @override
  List<Object> get props => [id, name, username, avatar];
}
