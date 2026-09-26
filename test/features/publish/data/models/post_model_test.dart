import 'package:code_connect_app/core/network/api_url.dart';
import 'package:code_connect_app/features/publish/data/models/author_model.dart';
import 'package:code_connect_app/features/publish/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tJsonPost = <String, dynamic>{
    'id': 1,
    'cover': 'https://example.com/cover.png',
    'imageUrl': '/uploads/image-123.jpg',
    'title': 'Introdução ao React',
    'body': 'Neste post, vamos explorar os conceitos básicos do React...',
    'markdown': '```javascript\nfunction HelloComponent() {\n  return <h1>Hello, world!</h1>;\n}\n```',
    'likes': 42,
    'author': <String, dynamic>{
      'id': 'clxyz123abc',
      'name': 'João Silva',
      'username': 'joaosilva_dev',
      'avatar': 'https://example.com/avatar.png',
    },
    'comments': <dynamic>[null],
    'createdAt': '2024-01-01T00:00:00.000Z',
    'updatedAt': '2024-01-01T00:00:00.000Z',
  };

  final tPostModel = PostModel(
    id: 1,
    title: 'Introdução ao React',
    body: 'Neste post, vamos explorar os conceitos básicos do React...',
    markdown: '```javascript\nfunction HelloComponent() {\n  return <h1>Hello, world!</h1>;\n}\n```',
    imageUrl: ApiUrl.resolve('/uploads/image-123.jpg'),
    likes: 42,
    author: const AuthorModel(
      id: 'clxyz123abc',
      name: 'João Silva',
      username: 'joaosilva_dev',
      avatar: 'https://example.com/avatar.png',
    ),
    createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
  );

  group('PostModel', () {
    test('Deve criar um PostModel a partir de um JSON completo', () {
      final post = PostModel.fromJson(tJsonPost);

      expect(post, equals(tPostModel));
    });

    test('Deve resolver imageUrl para URL absoluta quando ambos existem', () {
      final post = PostModel.fromJson(tJsonPost);

      expect(post.imageUrl, ApiUrl.resolve('/uploads/image-123.jpg'));
      expect(post.imageUrl, isNot(startsWith('/')));
    });

    test('Deve usar cover como fallback quando imageUrl não existir', () {
      final json = <String, dynamic>{...tJsonPost}..remove('imageUrl');

      final post = PostModel.fromJson(json);

      expect(post.imageUrl, 'https://example.com/cover.png');
    });

    test('Deve usar author default quando o author estiver ausente', () {
      final json = <String, dynamic>{...tJsonPost}..remove('author');

      final post = PostModel.fromJson(json);

      expect(
        post.author,
        const AuthorModel(id: '', name: '', username: '', avatar: ''),
      );
    });

    test('Deve setar createdAt como null quando ausente', () {
      final json = <String, dynamic>{...tJsonPost}..remove('createdAt');

      final post = PostModel.fromJson(json);

      expect(post.createdAt, isNull);
    });

    test('Deve usar defaults quando o JSON estiver vazio', () {
      final post = PostModel.fromJson(const {});

      expect(post.id, 0);
      expect(post.title, '');
      expect(post.body, '');
      expect(post.markdown, '');
      expect(post.imageUrl, '');
      expect(post.likes, 0);
      expect(post.author.id, '');
      expect(post.createdAt, isNull);
    });
  });

  group('PostModel.fromJsonList', () {
    test('Deve converter uma lista de JSONs em uma lista de PostModel', () {
      final posts = PostModel.fromJsonList(<dynamic>[tJsonPost, tJsonPost]);

      expect(posts, hasLength(2));
      expect(posts.first, equals(tPostModel));
      expect(posts.last, equals(tPostModel));
    });
  });

  group('AuthorModel', () {
    test('Deve criar um AuthorModel a partir de um JSON', () {
      final author = AuthorModel.fromJson({
        'id': 'clxyz123abc',
        'name': 'João Silva',
        'username': 'joaosilva_dev',
        'avatar': 'https://example.com/avatar.png',
      });

      expect(
        author,
        const AuthorModel(
          id: 'clxyz123abc',
          name: 'João Silva',
          username: 'joaosilva_dev',
          avatar: 'https://example.com/avatar.png',
        ),
      );
    });

    test('Deve usar defaults quando o JSON do author estiver vazio', () {
      final author = AuthorModel.fromJson(const {});

      expect(author.id, '');
      expect(author.name, '');
      expect(author.username, '');
      expect(author.avatar, '');
    });
  });
}