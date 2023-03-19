import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';
import 'package:movies/features/movies/presentation/manager/top_rated_bloc/top_rated_bloc.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          //TODO: Search Movies
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //TODO: nowPlaying
            const Carousel(),
            //  TODO: popular
            BlocBuilder<PopularBloc, PopularState>(
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
            //  TODO: top_rated
            BlocBuilder<TopRatedBloc, TopRatedState>(
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
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
