part of 'upcoming_bloc.dart';

abstract class UpcomingState extends Equatable {
  final List<MovieEntity> movies;
  const UpcomingState(this.movies);

  @override
  List<Object> get props => [movies];
}

class UpcomingInitial extends UpcomingState {
  const UpcomingInitial(super.movies);
  @override
  List<Object> get props => [movies];
}

class UpComingLoading extends UpcomingState {
  const UpComingLoading(super.movies);
  @override
  List<Object> get props => [movies];
}

class UpComingSuccess extends UpcomingState {
  final List<MovieEntity> newMovies;

  const UpComingSuccess(this.newMovies) : super(newMovies);

  @override
  List<Object> get props => [newMovies];
}

class UpComingFailure extends UpcomingState {
  final String errorMsg;
  const UpComingFailure(super.movies, this.errorMsg);

  @override
  List<Object> get props => [movies, errorMsg];
}
