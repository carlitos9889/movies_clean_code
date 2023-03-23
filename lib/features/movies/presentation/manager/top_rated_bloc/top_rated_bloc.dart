import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/use_cases/top_rated_use_case.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final TopRatedUseCase useCase;
  bool isLoading = false;
  int page = 0;

  TopRatedBloc(this.useCase) : super(const TopRatedInitial([])) {
    on<TopRatedEvent>((event, emit) async {
      if (event is TopRatedEventMovies) {
        if (isLoading) return;
        isLoading = true;
        page++;
        if (page == 1) {
          emit(const TopRatedLoading([]));
        }
        if (isLoading && page < 500) {
          final failureOrMovies = await useCase(ParamPage(page.toString()));
          failureOrMovies.fold(
            (l) => emit(
              TopRatedFailure(state.movies, 'Error to Load TopRated'),
            ),
            (newMovies) {
              if (newMovies.isNotEmpty) {
                emit(TopRatedSuccess([...state.movies, ...newMovies]));
                isLoading = false;
              } else {
                emit(TopRatedSuccess(state.movies));
                isLoading = false;
              }
            },
          );
        }
      }
    });
  }
}
