// features/auth/data/repositories/auth_repository_impl.dart
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Result<UserEntity>> login({required String email, required String password}) async {
    if (!await networkInfo.isConnected) {
      return const ResultError(NetworkFailure());
    }
    try {
      final user = await remoteDataSource.login(email: email, password: password);
      return Success(user.toEntity());
    } on UnauthorizedException catch (e) {
      return ResultError(UnauthorizedFailure(message: e.message));
    } on ServerException catch (e) {
      return ResultError(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return ResultError(ServerFailure(message: e.toString()));
    }
  }
}

