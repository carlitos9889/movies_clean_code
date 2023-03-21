import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/error.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParamPage extends Equatable {
  final String page;

  const ParamPage(this.page);

  @override
  List<Object?> get props => [page];
}

class ParamQuery extends Equatable {
  final String query;

  const ParamQuery(this.query);
  @override
  List<Object?> get props => [query];
}

class ParamMovieEntity extends Equatable {
  final MovieEntity movie;

  const ParamMovieEntity(this.movie);

  @override
  List<Object?> get props => [movie];
}
