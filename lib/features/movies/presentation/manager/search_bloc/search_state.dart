part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;

  const SearchSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class SearchEmpty extends SearchState {}

class SearchFailure extends SearchState {
  final String errorMsg;

  const SearchFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}

class SearchAddMovieToHistorySuccess extends SearchState {}

class SearchAddMovieToHistoryFailure extends SearchState {
  final String errorMsg;

  const SearchAddMovieToHistoryFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
