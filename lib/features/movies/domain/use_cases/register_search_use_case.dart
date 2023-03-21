import 'package:movies/core/error/error.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/repositories/movie_respository.dart';

class RegisterSearchUseCase extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  RegisterSearchUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await repository.registerSearch();
  }
}
