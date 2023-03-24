part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventMovies extends SearchEvent {
  final String query;

  const SearchEventMovies(this.query);

  @override
  List<Object> get props => [query];
}

class SearchEventAddMovieToHistorySearch extends SearchEvent {
  final MovieEntity movie;

  const SearchEventAddMovieToHistorySearch(this.movie);

  @override
  List<Object> get props => [movie];
}
