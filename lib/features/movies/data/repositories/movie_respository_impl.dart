import 'package:dartz/dartz.dart';
import 'package:movies/core/error/error.dart';
import 'package:movies/core/error/exception.dart';
import 'package:movies/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source.dart';
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
    return await _getMovies(() => remoteDataSource.searchMovie(query));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> registerSearch() async {
    try {
      final movies = await localDataSource.registerSearch();
      return Right(movies);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateRegisterSearch(MovieEntity movie) async {
    try {
      final nothing = await localDataSource.updateRegisterSearch(movie);
      return Right(nothing);
    } on CacheException {
      return Left(CacheFailure());
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
}
