import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/child_category_entity.dart';
import '../repositories/child_category_repository.dart';

class GetChildCategories {
  final ChildCategoryRepository repository;

  GetChildCategories(this.repository);

  Future<Either<Failure, List<ChildCategoryEntity>>> call() async {
    return await repository.getChildCategories();
  }
}
