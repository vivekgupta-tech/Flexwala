import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/poster_entity.dart';
import '../../domain/repositories/poster_repository.dart';
import '../datasources/poster_remote_datasource.dart';

class PosterRepositoryImpl implements PosterRepository {
  final PosterRemoteDataSource remoteDataSource;

  PosterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PosterEntity>>> getPosters() async {
    try {
      final remoteData = await remoteDataSource.getPosters();
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
