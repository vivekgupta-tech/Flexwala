import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sub_category_entity.dart';

abstract class SubCategoryRepository {
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories();
}
