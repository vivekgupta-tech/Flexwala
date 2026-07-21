import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/poster_entity.dart';
import '../repositories/poster_repository.dart';

class GetPosters {
  final PosterRepository repository;

  GetPosters(this.repository);

  Future<Either<Failure, List<PosterEntity>>> call() async {
    return await repository.getPosters();
  }
}
