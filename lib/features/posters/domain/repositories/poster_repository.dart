import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/poster_entity.dart';

abstract class PosterRepository {
  Future<Either<Failure, List<PosterEntity>>> getPosters();
}
