import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/child_category_entity.dart';

abstract class ChildCategoryRepository {
  Future<Either<Failure, List<ChildCategoryEntity>>> getChildCategories();
}
