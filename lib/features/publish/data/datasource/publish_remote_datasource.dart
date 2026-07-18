import 'package:code_connect_app/features/publish/data/models/publish_request_model.dart';
import 'package:code_connect_app/features/publish/data/models/publish_response_model.dart';
import 'package:dio/dio.dart';

class PublishRemoteDatasource {
  final Dio dio;

  PublishRemoteDatasource(this.dio);

  Future<PublishResponseModel> publish(PublishRequestModel request) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        "/blog-posts",
        data: await request.toFormData(),
      );

      return PublishResponseModel.fromJson(response.data!);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        throw Exception(data["message"] ?? "Erro ao publicar o post.");
      }

      throw Exception("Erro ao publicar o post.");
    }
  }
}
