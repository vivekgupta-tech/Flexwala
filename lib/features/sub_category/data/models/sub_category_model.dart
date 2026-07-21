import '../../domain/entities/sub_category_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.id,
    required super.categoryId,
    required super.title,
    super.image,
    super.categoryTitle,
    super.imageUrl,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['sub_id'] ?? '',
      categoryId: json['cate_id'] ?? '',
      title: json['sub_title'] ?? '',
      image: json['sub_image'],
      categoryTitle: json['cate_title'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub_id': id,
      'cate_id': categoryId,
      'sub_title': title,
      'sub_image': image,
      'cate_title': categoryTitle,
      'image_url': imageUrl,
    };
  }
}
