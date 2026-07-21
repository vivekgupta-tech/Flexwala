import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/repositories/banner_repository.dart';
import '../datasources/banner_remote_datasource.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;

  BannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BannerEntity>> getBannerDetails(String categoryId, String childId) async {
    try {
      final remoteData = await remoteDataSource.getBannerDetails(categoryId, childId);
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
