import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient client;
  ProfileRemoteDataSourceImpl(this.client);

  @override
  Future<ProfileModel> getProfile() async {
    // Note: Temporary static cust_id = 2 as requested. 
    // This should be replaced with dynamic ID from login/storage later.
    final response = await client.post(
      ApiEndpoints.getProfile,
      data: {'cust_id': '2'},
    );
    
    if (response.data['success'] == true) {
      return ProfileModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch profile');
    }
  }
}
