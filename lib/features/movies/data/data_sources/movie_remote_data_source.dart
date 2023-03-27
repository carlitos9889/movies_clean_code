import 'package:movies/features/movies/data/models/actor_model/actor_model.dart';
import 'package:movies/features/movies/data/models/movie_model/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> nowPlaying(String page);
  Future<List<MovieModel>> popular(String page);
  Future<List<MovieModel>> topRated(String page);
  Future<List<MovieModel>> upComing(String page);
  Future<List<MovieModel>> searchMovie(String query);
  Future<List<ActorModel>> castMovieXid(String id);
}
