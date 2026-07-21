import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/banner_entity.dart';
import '../repositories/banner_repository.dart';

class GetBannerDetails {
  final BannerRepository repository;

  GetBannerDetails(this.repository);

  Future<Either<Failure, BannerEntity>> call(String categoryId, String childId) async {
    return await repository.getBannerDetails(categoryId, childId);
  }
}
