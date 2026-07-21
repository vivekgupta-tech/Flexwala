import '../../domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.mainId,
    required super.title,
    required super.categoryId,
    required super.subCategoryId,
    required super.childId,
    required super.uploads,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      mainId: json['banner_main_id'] ?? '',
      title: json['title'] ?? '',
      categoryId: json['cate_id'] ?? '',
      subCategoryId: json['sub_id'] ?? '',
      childId: json['child_id'] ?? '',
      uploads: (json['banner_uploads'] as List? ?? [])
          .map((e) => BannerUploadModel.fromJson(e))
          .toList(),
    );
  }
}

class BannerUploadModel extends BannerUploadEntity {
  const BannerUploadModel({
    required super.bannerId,
    required super.title,
    super.imageUrl,
  });

  factory BannerUploadModel.fromJson(Map<String, dynamic> json) {
    String? imgUrl = json['image_url'];
    
    // If image_url is missing, check the 'images' array from the screenshot
    if (imgUrl == null || imgUrl.isEmpty) {
      final images = json['images'];
      if (images is List && images.isNotEmpty) {
        imgUrl = images[0].toString();
      }
    }

    return BannerUploadModel(
      bannerId: json['banner_id']?.toString() ?? '',
      title: json['banner_title'] ?? '',
      imageUrl: imgUrl,
    );
  }
}
