import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> getProfile() async {
    final response = await datasource.getProfile();

    return response;
  }
}
