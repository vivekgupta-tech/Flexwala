import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sub_category_entity.dart';
import '../repositories/sub_category_repository.dart';

class GetSubCategoriesUseCase {
  final SubCategoryRepository repository;

  GetSubCategoriesUseCase(this.repository);

  Future<Either<Failure, List<SubCategoryEntity>>> call() async {
    return await repository.getSubCategories();
  }
}
