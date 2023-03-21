import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/use_cases/search_movie_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovieUseCase useCase;
  SearchBloc(this.useCase) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchEventMovies) {
        emit(SearchLoading());
        final failureOrMovie = await useCase(ParamQuery(event.query));
        failureOrMovie.fold(
          (failure) => emit(const SearchFailure('Error to load search')),
          (movies) => emit(SearchSuccess(movies)),
        );
      }
    });
  }
}
