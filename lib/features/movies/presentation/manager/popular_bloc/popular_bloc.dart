import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/use_cases/popular_use_case.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final PopularUseCase useCase;
  int page = 0;

  PopularBloc(this.useCase) : super(const PopularInitial([])) {
    on<PopularEvent>((event, emit) async {
      if (event is PopularEventMovies) {
        page++;
        if (page == 1) {
          emit(const PopularLoading([]));
        }
        final failureOrMovies = await useCase(ParamPage(page.toString()));
        failureOrMovies.fold(
          (l) => emit(const PopularFailure([], 'Error to Load Popular')),
          (newMovies) {
            if (newMovies.isNotEmpty) {
              emit(PopularSuccess([...state.movies, ...newMovies]));
            }
          },
        );
      }
    });
  }
}
