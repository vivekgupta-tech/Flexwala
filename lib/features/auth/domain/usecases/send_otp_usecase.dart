import '../../../../core/error/result.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;
  SendOtpUseCase(this.repository);

  Future<Result<Map<String, dynamic>>> call({required String mobile}) {
    return repository.sendOtp(mobile: mobile);
  }
}
