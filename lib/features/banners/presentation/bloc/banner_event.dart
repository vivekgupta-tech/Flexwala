import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class FetchBannerDetails extends BannerEvent {
  final String categoryId;
  final String childId;

  const FetchBannerDetails({required this.categoryId, required this.childId});

  @override
  List<Object> get props => [categoryId, childId];
}
