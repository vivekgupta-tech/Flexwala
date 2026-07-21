import '../../domain/entities/child_category_entity.dart';

class ChildCategoryModel extends ChildCategoryEntity {
  const ChildCategoryModel({
    required super.id,
    required super.categoryId,
    required super.subCategoryId,
    required super.title,
    super.image,
    super.categoryTitle,
    super.subCategoryTitle,
    super.imageUrl,
  });

  factory ChildCategoryModel.fromJson(Map<String, dynamic> json) {
    return ChildCategoryModel(
      id: json['child_id'] ?? '',
      categoryId: json['cate_id'] ?? '',
      subCategoryId: json['sub_id'] ?? '',
      title: json['child_title'] ?? '',
      image: json['child_image'],
      categoryTitle: json['cate_title'],
      subCategoryTitle: json['sub_title'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': id,
      'cate_id': categoryId,
      'sub_id': subCategoryId,
      'child_title': title,
      'child_image': image,
      'cate_title': categoryTitle,
      'sub_title': subCategoryTitle,
      'image_url': imageUrl,
    };
  }
}
