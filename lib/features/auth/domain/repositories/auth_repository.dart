import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<Map<String, dynamic>>> sendOtp({required String mobile});
  Future<Result<UserEntity>> verifyOtp({required String mobile, required String otp});
}
