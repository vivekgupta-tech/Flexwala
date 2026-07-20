import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';
import '../models/otp_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<OtpResponseModel> sendOtp({required String mobile});
  Future<UserModel> verifyOtp({required String mobile, required String otp});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<OtpResponseModel> sendOtp({required String mobile}) async {
    final response = await client.post(ApiEndpoints.sendOtp, data: {
      'mobile': mobile,
    });
    return OtpResponseModel.fromJson(response.data);
  }

  @override
  Future<UserModel> verifyOtp({required String mobile, required String otp}) async {
    final response = await client.post(ApiEndpoints.verifyOtp, data: {
      'mobile': mobile,
      'otp': otp,
    });
    // Assuming verifyOtp returns user data in a 'data' field or similar
    // Based on standard practices, even if the screenshot showed HTML (which might be an error or redirect)
    return UserModel.fromJson(response.data['data'] ?? response.data);
  }
}
