part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();
}

class NowPlayingEventMovies extends NowPlayingEvent {

  const NowPlayingEventMovies();
  @override
  List<Object?> get props => [];
}
