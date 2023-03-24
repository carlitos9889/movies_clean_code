import 'package:movies/features/movies/domain/entities/movie_entity.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieEntity>> historySearch();
  Future<void> addMovieToHistorySearch(MovieEntity movie);
}
