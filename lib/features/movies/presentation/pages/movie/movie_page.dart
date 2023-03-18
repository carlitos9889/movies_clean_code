import 'package:flutter/material.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/presentation/pages/movie/widgets/custom_sliver_app_bar.dart';
import 'package:movies/features/movies/presentation/pages/movie/widgets/movie_poster.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);
  static const String routeName = 'movie';

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as MovieEntity;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              MoviePoster(movie),
            ]),
          )
        ],
      ),
    );
  }
}
