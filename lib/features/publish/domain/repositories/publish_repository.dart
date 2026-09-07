import 'dart:io';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PublishRepository {
  Future<Either<Failure, Post>> postPublish(
    String title,
    String body,
    String markdown,
    File image,
  );
}
