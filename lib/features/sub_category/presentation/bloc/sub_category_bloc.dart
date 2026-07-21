import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/sub_category_entity.dart';
import '../../domain/usecases/get_sub_categories_usecase.dart';

// Events
abstract class SubCategoryEvent extends Equatable {
  const SubCategoryEvent();
  @override
  List<Object?> get props => [];
}

class FetchSubCategories extends SubCategoryEvent {}

// States
abstract class SubCategoryState extends Equatable {
  const SubCategoryState();
  @override
  List<Object?> get props => [];
}

class SubCategoryInitial extends SubCategoryState {}
class SubCategoryLoading extends SubCategoryState {}
class SubCategoryLoaded extends SubCategoryState {
  final List<SubCategoryEntity> subCategories;
  const SubCategoryLoaded(this.subCategories);
  @override
  List<Object?> get props => [subCategories];
}
class SubCategoryError extends SubCategoryState {
  final String message;
  const SubCategoryError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final GetSubCategoriesUseCase getSubCategoriesUseCase;

  SubCategoryBloc({required this.getSubCategoriesUseCase}) : super(SubCategoryInitial()) {
    on<FetchSubCategories>((event, emit) async {
      emit(SubCategoryLoading());
      final result = await getSubCategoriesUseCase();
      result.fold(
        (failure) => emit(SubCategoryError(failure.message)),
        (subCategories) => emit(SubCategoryLoaded(subCategories)),
      );
    });
  }
}
