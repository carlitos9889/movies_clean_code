part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();
}

class NowPlayingEventMovies extends NowPlayingEvent {
  final String page;

  const NowPlayingEventMovies(this.page);
  @override
  List<Object?> get props => [page];
}
