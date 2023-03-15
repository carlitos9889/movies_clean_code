import 'package:movies/features/movies/domain/entities/movie_entity.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieEntity>> nowPlaying(String page);
  Future<List<MovieEntity>> popular(String page);
  Future<List<MovieEntity>> topRated(String page);
  Future<List<MovieEntity>> upComing(String page);
}
