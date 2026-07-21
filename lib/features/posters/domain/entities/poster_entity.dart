import 'package:equatable/equatable.dart';

class PosterEntity extends Equatable {
  final String id;
  final String childId;
  final String title;
  final String? image;
  final String? imageUrl;

  const PosterEntity({
    required this.id,
    required this.childId,
    required this.title,
    this.image,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, childId, title, image, imageUrl];
}
