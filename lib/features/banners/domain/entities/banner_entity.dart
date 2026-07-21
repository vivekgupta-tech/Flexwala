import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String mainId;
  final String title;
  final String categoryId;
  final String subCategoryId;
  final String childId;
  final List<BannerUploadEntity> uploads;

  const BannerEntity({
    required this.mainId,
    required this.title,
    required this.categoryId,
    required this.subCategoryId,
    required this.childId,
    required this.uploads,
  });

  @override
  List<Object?> get props => [mainId, title, categoryId, subCategoryId, childId, uploads];
}

class BannerUploadEntity extends Equatable {
  final String bannerId;
  final String title;
  final String? imageUrl;

  const BannerUploadEntity({
    required this.bannerId,
    required this.title,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [bannerId, title, imageUrl];
}
