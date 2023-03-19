import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/use_cases/upcoming_use_case.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final UpComingUseCase useCase;
  bool isLoading = false;
  int page = 0;

  UpcomingBloc(this.useCase) : super(const UpcomingInitial([])) {
    on<UpcomingEvent>((event, emit) async {
      if (event is UpcomingEventMovies) {
        if (isLoading) return;
        isLoading = true;
        page++;
        if (page == 1) {
          emit(const UpComingLoading([]));
        }
        if (isLoading && page <= 5) {
          final failureOrMovies = await useCase(ParamPage(page.toString()));
          failureOrMovies.fold(
            (l) => emit(UpComingFailure(state.movies, 'Error to Load Popular')),
            (newMovies) {
              if (newMovies.isNotEmpty) {
                emit(UpComingSuccess([...state.movies, ...newMovies]));
                isLoading = false;
              } else {
                emit(UpComingSuccess(state.movies));
                isLoading = false;
              }
            },
          );
        }
      }
    });
  }
}
