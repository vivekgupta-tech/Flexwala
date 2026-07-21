import 'package:equatable/equatable.dart';

abstract class ChildCategoryEvent extends Equatable {
  const ChildCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchChildCategories extends ChildCategoryEvent {}
