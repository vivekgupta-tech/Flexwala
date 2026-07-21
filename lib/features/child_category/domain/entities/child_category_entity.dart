import 'package:equatable/equatable.dart';

class ChildCategoryEntity extends Equatable {
  final String id;
  final String categoryId;
  final String subCategoryId;
  final String title;
  final String? image;
  final String? categoryTitle;
  final String? subCategoryTitle;
  final String? imageUrl;

  const ChildCategoryEntity({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    this.image,
    this.categoryTitle,
    this.subCategoryTitle,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        subCategoryId,
        title,
        image,
        categoryTitle,
        subCategoryTitle,
        imageUrl,
      ];
}
