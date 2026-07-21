import 'package:equatable/equatable.dart';
import '../../domain/entities/child_category_entity.dart';

abstract class ChildCategoryState extends Equatable {
  const ChildCategoryState();

  @override
  List<Object> get props => [];
}

class ChildCategoryInitial extends ChildCategoryState {}

class ChildCategoryLoading extends ChildCategoryState {}

class ChildCategoryLoaded extends ChildCategoryState {
  final List<ChildCategoryEntity> childCategories;

  const ChildCategoryLoaded(this.childCategories);

  @override
  List<Object> get props => [childCategories];
}

class ChildCategoryError extends ChildCategoryState {
  final String message;

  const ChildCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
