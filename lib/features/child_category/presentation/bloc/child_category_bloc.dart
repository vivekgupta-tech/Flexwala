import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/child_category_entity.dart';
import '../../domain/usecases/get_child_categories.dart';
import 'child_category_event.dart';
import 'child_category_state.dart';

class ChildCategoryBloc extends Bloc<ChildCategoryEvent, ChildCategoryState> {
  final GetChildCategories getChildCategories;

  ChildCategoryBloc({required this.getChildCategories}) : super(ChildCategoryInitial()) {
    on<FetchChildCategories>((event, emit) async {
      emit(ChildCategoryLoading());
      final Either<Failure, List<ChildCategoryEntity>> result = await getChildCategories();
      result.fold(
        (failure) => emit(ChildCategoryError(failure.message)),
        (childCategories) => emit(ChildCategoryLoaded(childCategories)),
      );
    });
  }
}
