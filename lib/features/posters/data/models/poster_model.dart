import '../../domain/entities/poster_entity.dart';

class PosterModel extends PosterEntity {
  const PosterModel({
    required super.id,
    required super.childId,
    required super.title,
    super.image,
    super.imageUrl,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(
      id: json['poster_id']?.toString() ?? json['id']?.toString() ?? '',
      childId: json['child_id']?.toString() ?? '',
      title: json['poster_title'] ?? json['title'] ?? '',
      image: json['poster_image'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poster_id': id,
      'child_id': childId,
      'poster_title': title,
      'poster_image': image,
      'image_url': imageUrl,
    };
  }
}
