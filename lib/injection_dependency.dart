import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movies/features/movies/data/data_sources/movie_local_data_source_impl.dart';
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movies/features/movies/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:movies/features/movies/data/repositories/movie_respository_impl.dart';
import 'package:movies/features/movies/domain/repositories/movie_respository.dart';
import 'package:movies/features/movies/domain/use_cases/now_playing_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/popular_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/search_movie_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/top_rated_use_case.dart';
import 'package:movies/features/movies/domain/use_cases/upcoming_use_case.dart';
import 'package:movies/features/movies/presentation/manager/now_playing_bloc/now_playing_bloc.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';
import 'package:movies/features/movies/presentation/manager/search_bloc/search_bloc.dart';
import 'package:movies/features/movies/presentation/manager/top_rated_bloc/top_rated_bloc.dart';
import 'package:movies/features/movies/presentation/manager/upcoming_bloc/upcoming_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  sl.registerFactory<UpcomingBloc>(
    () => UpcomingBloc(sl()),
  );
  sl.registerFactory<SearchBloc>(
    () => SearchBloc(sl()),
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

  sl.registerLazySingleton<SearchMovieUseCase>(
    () => SearchMovieUseCase(sl()),
  );

//  Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl(), sl()),
  );
//  DataSources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(sl()),
  );
//!  Core
//! External
  final client = http.Client();
  sl.registerLazySingleton<http.Client>(
    () => client,
  );
  final preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => preferences);
}
