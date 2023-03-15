part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  final List<MovieEntity> movies;

  const NowPlayingState(this.movies);
}

class NowPlayingInitial extends NowPlayingState {
  const NowPlayingInitial(super.movies);

  @override
  List<Object> get props => [movies];
}

class NowPlayingLoading extends NowPlayingState {
  const NowPlayingLoading(super.movies);

  @override
  List<Object?> get props => [movies];
}

class NowPlayingSuccess extends NowPlayingState {
  final List<MovieEntity> newMovies;

  const NowPlayingSuccess(this.newMovies) : super(newMovies);

  @override
  List<Object?> get props => [newMovies];
}

class NowPlayingFailure extends NowPlayingState {
  const NowPlayingFailure(super.movies, this.errorMsg);
  final String errorMsg;

  @override
  List<Object?> get props => [errorMsg, movies];
}
