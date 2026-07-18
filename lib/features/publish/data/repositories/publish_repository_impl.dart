import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/data/models/publish_request_model.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';

class PublishRepositoryImpl implements PublishRepository {
  final PublishRemoteDatasource datasource;

  PublishRepositoryImpl(this.datasource);

  @override
  Future<Post> publish(PublishRequestModel request) async {
    final response = await datasource.publish(request);

    return response.toEntity();
  }
}
