import 'package:code_connect_app/features/publish/data/models/publish_request_model.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';

abstract class PublishRepository {
  Future<Post> publish(PublishRequestModel request);
}
