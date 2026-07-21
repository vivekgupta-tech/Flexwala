import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/banner_entity.dart';

abstract class BannerRepository {
  Future<Either<Failure, BannerEntity>> getBannerDetails(String categoryId, String childId);
}
