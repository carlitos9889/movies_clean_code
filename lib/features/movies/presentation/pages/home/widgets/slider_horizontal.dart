import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/const_app.dart';
import 'package:movies/core/helpers/format_number.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';

class SliderHorizontal extends StatefulWidget {
  const SliderHorizontal({
    Key? key,
    required this.movies,
    required this.title,
    required this.controller,
    required this.listener,
    required this.onTap,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final List<MovieEntity> movies;
  final PageController controller;
  final Function listener;
  final void Function(MovieEntity movie, String tag) onTap;
  @override
  State<SliderHorizontal> createState() => _SliderHorizontalState();
}

class _SliderHorizontalState extends State<SliderHorizontal> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.position.pixels >=
          widget.controller.position.maxScrollExtent - 200) {
        widget.listener();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(
          title: widget.title,
          subtitle: widget.subtitle,
        ),
        SizedBox(
          height: 230,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            pageSnapping: false,
            controller: widget.controller,
            itemCount: widget.movies.length,
            itemBuilder: (_, i) {
              final movie = widget.movies[i];
              final title = widget.title;
              final onTap = widget.onTap;
              return SliderHorizontalItem(movie, title, onTap);
            },
          ),
        ),
      ],
    );
  }
}

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          Text(title, style: themeText.titleLarge),
          const Spacer(),
          FilledButton.tonal(
            onPressed: () {},
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
            child: Text(subtitle),
          ),
        ],
      ),
    );
  }
}

class SliderHorizontalItem extends StatelessWidget {
  const SliderHorizontalItem(this.movie, this.title, this.onTap, {Key? key})
      : super(key: key);

  final String title;

  final MovieEntity movie;
  final void Function(MovieEntity movie, String tag) onTap;

  @override
  Widget build(BuildContext context) {
    final tag = movie.id.toString() + title;
    final textTheme = Theme.of(context).textTheme;

    final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black38, blurRadius: 13, offset: Offset(0, 10)),
      ],
    );
    final poster = GestureDetector(
      onTap: () => onTap(movie, tag),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, right: 20),
        child: DecoratedBox(
          decoration: decoration,
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(ConstApp.placeholder),
                image: CachedNetworkImageProvider(
                  '${ConstApp.urlImage}${movie.poster_path}',
                ),
              ),
            ),
          ),
        ),
      ),
    );
    final infoMovie = SizedBox(
      width: 100,
      child: Text(
        movie.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleSmall,
      ),
    );

    final rating = Row(
      children: [
        Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
        Text(
          movie.vote_average.toString(),
          style: textTheme.bodyMedium?.copyWith(color: Colors.yellow.shade800),
        ),
        const SizedBox(width: 7),
        // TODO: Formatear numero
        Text(FomatNumber().formatNumber(movie.popularity))
      ],
    );

    return Container(
      child: Column(children: [poster, infoMovie, rating]),
    );
  }
}
