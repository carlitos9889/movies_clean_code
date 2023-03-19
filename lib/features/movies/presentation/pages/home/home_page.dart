import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/presentation/delegate.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';
import 'package:movies/features/movies/presentation/manager/top_rated_bloc/top_rated_bloc.dart';
import 'package:movies/features/movies/presentation/manager/upcoming_bloc/upcoming_bloc.dart';
import 'package:movies/features/movies/presentation/pages/home/widgets/carousel.dart';
import 'package:movies/features/movies/presentation/pages/home/widgets/slider_horizontal.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          //TODO: Search Movies
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchDelegateMovie(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Carousel(),
            BlocBuilder<PopularBloc, PopularState>(
              buildWhen: (previous, current) {
                return previous.movies != current.movies;
              },
              builder: (context, state) {
                if (state is PopularLoading || state is PopularInitial) {
                  return const LoadingWidget(height: 200);
                }
                if (state is PopularFailure) {
                  return Text(state.errorMsg);
                }
                return SliderHorizontal(
                  movies: state.movies,
                  title: 'Populars',
                  controller: popularController,
                  listener: () {
                    context.read<PopularBloc>().add(const PopularEventMovies());
                  },
                );
              },
            ),
            BlocBuilder<TopRatedBloc, TopRatedState>(
              buildWhen: (previous, current) {
                return previous.movies != current.movies;
              },
              builder: (context, state) {
                if (state is TopRatedLoading || state is TopRatedInitial) {
                  return const LoadingWidget(height: 200);
                }
                if (state is TopRatedFailure) {
                  return Text(state.errorMsg);
                }
                return SliderHorizontal(
                  movies: state.movies,
                  title: 'TopRated',
                  controller: topRatedController,
                  listener: () {
                    context.read<TopRatedBloc>().add(TopRatedEventMovies());
                  },
                );
              },
            ),
            BlocBuilder<UpcomingBloc, UpcomingState>(
              buildWhen: (previous, current) {
                return previous.movies != current.movies;
              },
              builder: (context, state) {
                if (state is UpcomingInitial || state is UpComingLoading) {
                  return const LoadingWidget(height: 200);
                }
                if (state is UpComingFailure) {
                  return Text(state.errorMsg);
                }
                return SliderHorizontal(
                  movies: state.movies,
                  title: 'Upcoming',
                  controller: upComingController,
                  listener: () {
                    context.read<UpcomingBloc>().add(UpcomingEventMovies());
                  },
                );
              },
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
