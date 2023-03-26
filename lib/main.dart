import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/presentation/manager/nowplaying_bloc/nowplaying_bloc.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';
import 'package:movies/features/movies/presentation/manager/search_bloc/search_bloc.dart';
import 'package:movies/features/movies/presentation/manager/top_rated_bloc/top_rated_bloc.dart';
import 'package:movies/features/movies/presentation/manager/upcoming_bloc/upcoming_bloc.dart';
import 'package:movies/routes_app.dart';
import 'package:movies/theme.dart';

import 'injection_dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              sl<NowplayingBloc>()..add(const NowplayingEvent.movies()),
        ),
        BlocProvider(
          create: (_) => sl<PopularBloc>()..add(const PopularEvent.movies()),
        ),
        BlocProvider(
          create: (_) => sl<TopRatedBloc>()..add(const TopRatedEvent.movies()),
        ),
        BlocProvider(
          create: (_) => sl<UpcomingBloc>()..add(const UpcomingEvent.movies()),
        ),
        BlocProvider(create: (_) => sl<SearchBloc>())
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeApp.themeData,
        initialRoute: RoutesApp.initialRoute,
        routes: RoutesApp.router,
      ),
    );
  }
}
