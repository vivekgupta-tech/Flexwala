import 'package:equatable/equatable.dart';

class SubCategoryEntity extends Equatable {
  final String id;
  final String categoryId;
  final String title;
  final String? image;
  final String? categoryTitle;
  final String? imageUrl;

  const SubCategoryEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    this.image,
    this.categoryTitle,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, categoryId, title, image, categoryTitle, imageUrl];
}
