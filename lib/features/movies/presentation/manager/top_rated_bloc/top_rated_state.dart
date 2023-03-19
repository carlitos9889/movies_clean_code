part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  final List<MovieEntity> movies;

  const TopRatedState(this.movies);
}

class TopRatedInitial extends TopRatedState {
  const TopRatedInitial(super.movie);

  @override
  List<Object> get props => [movies];
}

class TopRatedLoading extends TopRatedState {
  const TopRatedLoading(super.movie);

  @override
  List<Object?> get props => [movies];
}

class TopRatedSuccess extends TopRatedState {
  final List<MovieEntity> newMovies;
  const TopRatedSuccess(this.newMovies) : super(newMovies);

  @override
  List<Object?> get props => [newMovies];
}

class TopRatedFailure extends TopRatedState {
  const TopRatedFailure(super.movie, this.errorMsg);

  final String errorMsg;

  @override
  List<Object?> get props => [movies, errorMsg];
}
