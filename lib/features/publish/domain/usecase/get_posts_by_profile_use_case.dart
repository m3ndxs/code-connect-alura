import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostsByProfileUseCase {
  final PublishRepository repository;
  GetPostsByProfileUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call(String profileId) async {
    return await repository.getPostsByProfile(profileId);
  }
}
