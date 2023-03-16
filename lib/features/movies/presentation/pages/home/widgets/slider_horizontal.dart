import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';

class SliderHorizontal extends StatelessWidget {
  const SliderHorizontal({
    Key? key,
    required this.movies,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Text(title, style: themeText.headlineMedium),
        ),
        SizedBox(
          height: 180,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            pageSnapping: false,
            controller: PageController(
              viewportFraction: 0.3,
              initialPage: 1,
            ),
            itemCount: movies.length,
            itemBuilder: (_, i) => SliderHorizontalItem(movies[i]),
          ),
        ),
      ],
    );
  }
}

class SliderHorizontalItem extends StatelessWidget {
  const SliderHorizontalItem(this.movie, {Key? key}) : super(key: key);

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          fit: BoxFit.fill,
          placeholder: const AssetImage('assets/img.jpg'),
          image: CachedNetworkImageProvider(
            'https://image.tmdb.org/t/p/w500${movie.poster_path}',
          ),
        ),
      ),
    );
  }
}
