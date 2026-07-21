import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<ProfileEntity>> getProfile() async {
    if (!await networkInfo.isConnected) {
      return const ResultError(NetworkFailure());
    }
    try {
      final profileModel = await remoteDataSource.getProfile();
      return Success(profileModel);
    } on ServerException catch (e) {
      return ResultError(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return ResultError(ServerFailure(message: e.toString()));
    }
  }
}
