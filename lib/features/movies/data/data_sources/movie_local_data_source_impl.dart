import 'dart:convert';

import 'package:movies/core/error/exception.dart';
import 'package:movies/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movies/features/movies/data/models/movie_model/movie_model.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final SharedPreferences preferences;

  MovieLocalDataSourceImpl(this.preferences);

  @override
  Future<List<MovieEntity>> historySearch() async {
    try {
      final dataCache = preferences.getString('movies');
      if (dataCache != null) {
        final data = jsonDecode(dataCache) as List;
        final movies =
            data.map((movie) => MovieModel.fromJson(movie)).toSet().toList();
        return movies;
      }
      return [];
    } catch (e) {
      print(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> addMovieToHistorySearch(MovieEntity movie) async {
    try {
      final movies = await historySearch();
      movies.insert(0, movie);
      if (movies.length >= 10) {
        movies.removeLast();
      }
      final encode = movies
          .map((movie) {
            final movieModel = MovieModel(
              backdrop_path: movie.backdrop_path,
              id: movie.id,
              original_title: movie.original_title,
              overview: movie.overview,
              popularity: movie.popularity,
              poster_path: movie.poster_path,
              title: movie.title,
              vote_average: movie.vote_average,
              vote_count: movie.vote_count,
            );
            return jsonEncode(movieModel.toJson());
          })
          .toSet()
          .toList();

      await preferences.setString('movies', encode.toString());
    } catch (e) {
      print(e.toString());
      throw CacheException();
    }
  }
}
