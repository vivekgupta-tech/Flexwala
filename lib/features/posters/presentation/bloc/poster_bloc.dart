import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/poster_entity.dart';
import '../../domain/usecases/get_posters.dart';
import 'poster_event.dart';
import 'poster_state.dart';

class PosterBloc extends Bloc<PosterEvent, PosterState> {
  final GetPosters getPosters;

  PosterBloc({required this.getPosters}) : super(PosterInitial()) {
    on<FetchPosters>((event, emit) async {
      emit(PosterLoading());
      final Either<Failure, List<PosterEntity>> result = await getPosters();
      result.fold(
        (failure) => emit(PosterError(failure.message)),
        (posters) => emit(PosterLoaded(posters)),
      );
    });
  }
}
