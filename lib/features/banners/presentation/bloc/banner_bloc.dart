import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/usecases/get_banner_details.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerDetails getBannerDetails;

  BannerBloc({required this.getBannerDetails}) : super(BannerInitial()) {
    on<FetchBannerDetails>((event, emit) async {
      emit(BannerLoading());
      final Either<Failure, BannerEntity> result = 
          await getBannerDetails(event.categoryId, event.childId);
      
      result.fold(
        (failure) => emit(BannerError(failure.message)),
        (banner) => emit(BannerLoaded(banner)),
      );
    });
  }
}
