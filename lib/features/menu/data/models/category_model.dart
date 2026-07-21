import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.title,
    super.image,
    super.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['cate_id'] ?? '',
      title: json['cate_title'] ?? '',
      image: json['cate_image'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cate_id': id,
      'cate_title': title,
      'cate_image': image,
      'image_url': imageUrl,
    };
  }
}
