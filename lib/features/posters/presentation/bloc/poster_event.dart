import 'package:equatable/equatable.dart';

abstract class PosterEvent extends Equatable {
  const PosterEvent();

  @override
  List<Object> get props => [];
}

class FetchPosters extends PosterEvent {}
