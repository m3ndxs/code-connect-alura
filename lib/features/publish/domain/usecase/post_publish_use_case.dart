import 'dart:io';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:dartz/dartz.dart';

class PostPublishUseCase {
  final PublishRepository repository;
  PostPublishUseCase(this.repository);

  Future<Either<Failure, Post>> call(
    String title,
    String body,
    String markdown,
    File image,
  ) async {
    return await repository.postPublish(title, body, markdown, image);
  }
}
