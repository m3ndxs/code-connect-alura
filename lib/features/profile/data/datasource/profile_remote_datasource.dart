import 'package:code_connect_app/features/profile/data/models/user_model.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasource(this.dio);

  Future<UserModel> getProfile() async {
    try {
      final response = await dio.get('/auth/me');

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
