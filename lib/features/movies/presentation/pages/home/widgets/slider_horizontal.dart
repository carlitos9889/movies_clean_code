import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/const_app.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';

class SliderHorizontal extends StatefulWidget {
  const SliderHorizontal({
    Key? key,
    required this.movies,
    required this.title,
    required this.controller,
    required this.listener,
    required this.onTap,
  }) : super(key: key);

  final String title;
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
    final themeText = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Text(widget.title, style: themeText.headlineMedium),
        ),
        SizedBox(
          height: 180,
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
        const SizedBox(height: 20),
      ],
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
    final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black38, blurRadius: 13, offset: Offset(0, 10)),
      ],
    );
    return GestureDetector(
      onTap: () => onTap(movie, tag),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10),
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
  }
}
