import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movies/features/movies/domain/entities/movie_entity.dart';

class SliderHorizontal extends StatefulWidget {
  const SliderHorizontal({
    Key? key,
    required this.movies,
    required this.title,
    required this.controller,
    required this.listener,
  }) : super(key: key);

  final String title;
  final List<MovieEntity> movies;
  final PageController controller;
  final Function listener;
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

  // Future<void> getMoreMovies() async {
  //   final popularBloc = context.read<PopularBloc>();
  //   popularBloc.add(const PopularEventMovies());
  // }

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
              return SliderHorizontalItem(widget.movies[i]);
            },
          ),
        ),
        const SizedBox(height: 20),
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
