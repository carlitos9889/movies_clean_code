import 'package:movies/core/error/error.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/repositories/movie_respository.dart';

class UpdateRegisterSearchUseCase extends UseCase<void, ParamMovieEntity> {
  final MovieRepository repository;

  UpdateRegisterSearchUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ParamMovieEntity params) async {
    return await repository.updateRegisterSearch(params.movie);
  }
}
