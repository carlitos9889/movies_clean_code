import 'dart:convert';

import 'package:movies/core/error/exception.dart';
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movies/features/movies/data/models/resp_api_model/resp_api_model.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl(this.client);

  @override
  Future<List<MovieEntity>> nowPlaying(String page) async {
    return await _getMovies(path: 'now_playing', page: page);
  }

  @override
  Future<List<MovieEntity>> popular(String page) async {
    return await _getMovies(path: 'popular', page: page);
  }

  @override
  Future<List<MovieEntity>> topRated(String page) async {
    return await _getMovies(path: 'top_rated', page: page);
  }

  @override
  Future<List<MovieEntity>> upComing(String page) async {
    return await _getMovies(path: 'upcoming', page: page);
  }

  @override
  Future<List<MovieEntity>> searchMovie(String query) async {
    final url = Uri.https('api.themoviedb.org', '3/search/movie', {
      'api_key': '99332a11f952aa0293b94e9b4b81d15f',
      'language': 'en-US',
      'query': query,
    });
    try {
      final response = await client.get(url);
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      final movies = ResApiModel.fromJson(jsonMap).results;
      return movies;
    } catch (_) {
      print(_.toString());
      throw ServerException();
    }
  }

  Future<List<MovieEntity>> _getMovies({
    required String path,
    required String page,
  }) async {
    final url = Uri.https('api.themoviedb.org', '3/movie/$path', {
      'api_key': '99332a11f952aa0293b94e9b4b81d15f',
      'language': 'en-US',
      'page': page,
    });
    try {
      final response = await client.get(url);
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      final movies = ResApiModel.fromJson(jsonMap).results;
      return movies;
    } catch (_) {
      throw ServerException();
    }
  }
}
