// features/auth/domain/repositories/auth_repository.dart
import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login({required String email, required String password});
}

