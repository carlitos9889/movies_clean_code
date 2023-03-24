import 'package:dartz/dartz.dart';
import 'package:movies/core/error/error.dart';
import 'package:movies/core/error/exception.dart';
import 'package:movies/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movies/features/movies/data/models/movie_model/movie_model.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/repositories/movie_respository.dart';

typedef GetMoviesType = Future<List<MovieEntity>> Function();

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> nowPlaying(String page) async {
    return await _getMovies(() => remoteDataSource.nowPlaying(page));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> popular(String page) async {
    return await _getMovies(() => remoteDataSource.popular(page));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> topRated(String page) async {
    return await _getMovies(() => remoteDataSource.topRated(page));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> upComing(String page) async {
    return await _getMovies(() => remoteDataSource.upComing(page));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovie(String query) async {
    if (query.isEmpty) {
      try {
        final movies = await localDataSource.historySearch();
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return await _getMovies(() => remoteDataSource.searchMovie(query));
    }
  }

  Future<Either<Failure, List<MovieEntity>>> _getMovies(
    GetMoviesType getMoviesType,
  ) async {
    try {
      final movies = await getMoviesType();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addMovieToHistorySearch(
    MovieEntity movie,
  ) async {
    try {
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
      final r = await localDataSource.addMovieToHistorySearch(movieModel);
      return Right(r);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
