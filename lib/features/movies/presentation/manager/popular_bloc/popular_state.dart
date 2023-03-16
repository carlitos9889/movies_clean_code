part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  final List<MovieEntity> movies;
  const PopularState(this.movies);
}

class PopularInitial extends PopularState {
  const PopularInitial(super.movies);

  @override
  List<Object> get props => [movies];
}

class PopularLoading extends PopularState {
  const PopularLoading(super.movies);

  @override
  List<Object?> get props => [];
}

class PopularSuccess extends PopularState {
  final List<MovieEntity> newMovies;

  const PopularSuccess(this.newMovies) : super(newMovies);
  @override
  List<Object?> get props => [newMovies];
}

class PopularFailure extends PopularState {
  final String errorMsg;

  const PopularFailure(super.movies, this.errorMsg);

  @override
  List<Object?> get props => [movies, errorMsg];
}
