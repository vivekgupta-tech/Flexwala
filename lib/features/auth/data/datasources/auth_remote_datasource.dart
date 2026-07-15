// features/auth/data/datasources/auth_remote_datasource.dart
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final response = await client.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data['user']);
  }
}

