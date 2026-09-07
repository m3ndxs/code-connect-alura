import 'dart:io';
import 'package:code_connect_app/core/errors/exceptions.dart';
import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:dartz/dartz.dart';

class PublishRepositoryImpl implements PublishRepository {
  final PublishRemoteDataSource remoteDataSource;
  PublishRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Post>> postPublish(
    String title,
    String body,
    String markdown,
    File image,
  ) async {
    try {
      final postModel = await remoteDataSource.postPublish(
        title,
        body,
        markdown,
        image,
      );
      return Right(postModel);
    } on ServerException catch (exception) {
      return Left(ServerFailure(exception.message));
    }
  }
}
