import 'package:dartz/dartz.dart';
import 'package:movies/core/error/error.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> nowPlaying(String page);
  Future<Either<Failure, List<MovieEntity>>> popular(String page);
  Future<Either<Failure, List<MovieEntity>>> topRated(String page);
  Future<Either<Failure, List<MovieEntity>>> upComing(String page);
}
