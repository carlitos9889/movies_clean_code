import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helpers/format_number.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/presentation/manager/cast_bloc/cast_bloc.dart';
import 'package:movies/features/movies/presentation/manager/nowplaying_bloc/nowplaying_bloc.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';
import 'package:movies/features/movies/presentation/manager/top_rated_bloc/top_rated_bloc.dart';
import 'package:movies/features/movies/presentation/manager/upcoming_bloc/upcoming_bloc.dart';
import 'package:movies/features/movies/presentation/pages/home/widgets/carousel.dart';
import 'package:movies/features/movies/presentation/pages/home/widgets/slider_horizontal.dart';
import 'package:movies/features/movies/presentation/pages/movie/movie_page.dart';
import 'package:movies/features/movies/presentation/widgets/cutom_navigation_bar.dart';
import 'package:movies/features/movies/presentation/widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final popularController = PageController(
      viewportFraction: 0.3,
      initialPage: 1,
    );
    final topRatedController = PageController(
      viewportFraction: 0.3,
      initialPage: 1,
    );
    final upComingController = PageController(
      viewportFraction: 0.3,
      initialPage: 1,
    );

    void onTap(MovieEntity movie, String tag) {
      context.read<CastBloc>().add(CastEvent.cast(movie.id.toString()));
      Navigator.pushNamed(
        context,
        MoviePage.routeName,
        arguments: [movie, tag],
      );
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Movies'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         showSearch(context: context, delegate: SearchDelegateMovie());
      //       },
      //       icon: const Icon(Icons.search),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            BlocBuilder<NowplayingBloc, NowplayingState>(
              buildWhen: (oldState, newState) => oldState != newState,
              builder: (context, state) => state.when(
                loading: () => LoadingWidget(height: size.height * 0.5),
                success: (movies) => Carousel(movies, onTap),
                failure: (message) => Text(message),
              ),
            ),
            BlocBuilder<PopularBloc, PopularState>(
              buildWhen: (p, c) => p.movies != c.movies,
              builder: (context, state) => state.when(
                loading: (_) => const LoadingWidget(height: 200),
                failure: (_, errorMsg) => Text(errorMsg),
                success: (movies) => SliderHorizontal(
                  subtitle: FormatDate().formatDate(DateTime.now()),
                  movies: movies,
                  onTap: onTap,
                  title: 'Popular',
                  controller: popularController,
                  listener: () => context
                      .read<PopularBloc>()
                      .add(const PopularEvent.movies()),
                ),
              ),
            ),
            BlocBuilder<TopRatedBloc, TopRatedState>(
              buildWhen: (p, c) => p.movies != c.movies,
              builder: (context, state) => state.when(
                loading: (_) => const LoadingWidget(height: 200),
                failure: (_, message) => Text(message),
                success: (movies) => SliderHorizontal(
                  subtitle: FormatDate().formatDate(DateTime.now()),
                  movies: movies,
                  onTap: onTap,
                  title: 'Top Rated',
                  controller: topRatedController,
                  listener: () => context
                      .read<TopRatedBloc>()
                      .add(const TopRatedEvent.movies()),
                ),
              ),
            ),
            BlocBuilder<UpcomingBloc, UpcomingState>(
              buildWhen: (p, c) => p.movies != c.movies,
              builder: (context, state) => state.when(
                loading: (_) => const LoadingWidget(height: 200),
                failure: (_, message) => Text(message),
                success: (movies) => SliderHorizontal(
                  subtitle: FormatDate().formatDate(DateTime.now()),
                  movies: movies,
                  onTap: onTap,
                  title: 'Up Coming',
                  controller: upComingController,
                  listener: () => context
                      .read<UpcomingBloc>()
                      .add(const UpcomingEvent.movies()),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
