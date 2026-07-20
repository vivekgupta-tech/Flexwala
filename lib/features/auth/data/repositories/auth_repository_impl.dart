import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final SecureStorageService storage;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo, this.storage);

  @override
  Future<Result<Map<String, dynamic>>> sendOtp({required String mobile}) async {
    if (!await networkInfo.isConnected) {
      return const ResultError(NetworkFailure());
    }
    try {
      final response = await remoteDataSource.sendOtp(mobile: mobile);
      return Success({
        'success': response.success,
        'message': response.message,
        'otp': response.data?.otp,
      });
    } on ServerException catch (e) {
      return ResultError(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return ResultError(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<UserEntity>> verifyOtp({required String mobile, required String otp}) async {
    if (!await networkInfo.isConnected) {
      return const ResultError(NetworkFailure());
    }
    try {
      final userModel = await remoteDataSource.verifyOtp(mobile: mobile, otp: otp);
      
      // Token save karna agar API se mila hai
      if (userModel.token != null) {
        await storage.saveTokens(
          accessToken: userModel.token!,
          refreshToken: '', // Agar refresh token nahi hai toh empty
        );
      }
      if (userModel.id.isNotEmpty) {
        await storage.saveUserId(userModel.id);
      }

      return Success(userModel.toEntity());
    } on UnauthorizedException catch (e) {
      return ResultError(UnauthorizedFailure(message: e.message));
    } on ServerException catch (e) {
      return ResultError(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return ResultError(ServerFailure(message: e.toString()));
    }
  }
}
