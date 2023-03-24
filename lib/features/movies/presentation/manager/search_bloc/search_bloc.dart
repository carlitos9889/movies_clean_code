import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/use_cases/add_movie_to_history_search_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/search_movie_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovieUseCase searchUseCase;
  final AddMovieToHistorySearchUseCase addMovieToHistorySearchUseCase;
  SearchBloc(
    this.searchUseCase,
    this.addMovieToHistorySearchUseCase,
  ) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchEventMovies) {
        emit(SearchLoading());
        final failureOrMovie = await searchUseCase(ParamQuery(event.query));
        failureOrMovie.fold(
          (failure) => emit(const SearchFailure('Error to load search')),
          (movies) => emit(SearchSuccess(movies)),
        );
      }
      if (event is SearchEventAddMovieToHistorySearch) {
        final failureOrVoid = await addMovieToHistorySearchUseCase(
          ParamsMovieEntity(event.movie),
        );
        failureOrVoid.fold(
          (failure) => emit(
            const SearchAddMovieToHistoryFailure('Error add movie to history'),
          ),
          (r) => emit(SearchAddMovieToHistorySuccess()),
        );
      }
    });
  }
}
