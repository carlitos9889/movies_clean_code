import 'package:flutter/material.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/presentation/pages/movie/widgets/custom_sliver_app_bar.dart';
import 'package:movies/features/movies/presentation/pages/movie/widgets/movie_poster.dart';
import 'package:movies/features/movies/presentation/pages/movie/widgets/slider_horizontal_cast.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);
  static const String routeName = 'movie';

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final movie = arguments[0] as MovieEntity;
    final tag = arguments[1] as String;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              MoviePoster(movie, tag),
              const SliderHorizontalCast(),
            ]),
          )
        ],
      ),
    );
  }
}
