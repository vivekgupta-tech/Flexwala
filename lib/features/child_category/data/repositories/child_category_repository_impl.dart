import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/child_category_entity.dart';
import '../../domain/repositories/child_category_repository.dart';
import '../datasources/child_category_remote_datasource.dart';

class ChildCategoryRepositoryImpl implements ChildCategoryRepository {
  final ChildCategoryRemoteDataSource remoteDataSource;

  ChildCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ChildCategoryEntity>>> getChildCategories() async {
    try {
      final remoteData = await remoteDataSource.getChildCategories();
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
