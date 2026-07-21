import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String title;
  final String? image;
  final String? imageUrl;

  const CategoryEntity({
    required this.id,
    required this.title,
    this.image,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, image, imageUrl];
}
