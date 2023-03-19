import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:movies/features/movies/data/repositories/movie_respository_impl.dart';
import 'package:movies/features/movies/domain/repositories/movie_respository.dart';
import 'package:movies/features/movies/domain/use_cases/now_playing_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/popular_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/top_rated_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/upcoming_use_case.dart';
import 'package:movies/features/movies/presentation/manager/now_playing_bloc/now_playing_bloc.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';
import 'package:movies/features/movies/presentation/manager/top_rated_bloc/top_rated_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//!  Features
//  Blocs
  sl.registerFactory<NowPlayingBloc>(
    () => NowPlayingBloc(sl()),
  );
  sl.registerFactory<PopularBloc>(
    () => PopularBloc(sl()),
  );
  sl.registerFactory<TopRatedBloc>(
    () => TopRatedBloc(sl()),
  );

// Use Case
  sl.registerLazySingleton<NowPlayingUseCase>(
    () => NowPlayingUseCase(sl()),
  );
  sl.registerLazySingleton<PopularUseCase>(
    () => PopularUseCase(sl()),
  );
  sl.registerLazySingleton<TopRatedUseCase>(
    () => TopRatedUseCase(sl()),
  );
  sl.registerLazySingleton<UpComingUseCase>(
    () => UpComingUseCase(sl()),
  );
//  Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl()),
  );
//  DataSources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );
//!  Core
//! External
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
