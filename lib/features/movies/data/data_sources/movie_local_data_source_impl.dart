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
  Future<List<MovieEntity>> registerSearch() async {
    try {
      final dataCache = preferences.getString('movies');
      if (dataCache != null) {
        final data = jsonDecode(dataCache) as List<Map<String, dynamic>>;
        final movies = data.map((movie) => MovieModel.fromJson(movie)).toList();
        return movies;
      }
      return [];
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateRegisterSearch(MovieEntity entity) async {
    try {
      final movies = await registerSearch();
      movies.insert(0, entity);
      if (movies.length >= 7) {
        movies.removeLast();
      }
      await preferences.setString('movies', movies.toString());
    } catch (e) {
      throw CacheException();
    }
  }
}
