import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sub_category_entity.dart';
import '../../domain/repositories/sub_category_repository.dart';
import '../datasources/sub_category_remote_datasource.dart';

class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final SubCategoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SubCategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSubCategories = await remoteDataSource.getSubCategories();
        return Right(remoteSubCategories);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
