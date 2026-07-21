import '../../../../core/error/result.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity>> getProfile();
}
