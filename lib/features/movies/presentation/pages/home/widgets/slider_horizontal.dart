import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/presentation/manager/popular_bloc/popular_bloc.dart';

class SliderHorizontal extends StatefulWidget {
  const SliderHorizontal({
    Key? key,
    required this.movies,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<MovieEntity> movies;

  @override
  State<SliderHorizontal> createState() => _SliderHorizontalState();
}

class _SliderHorizontalState extends State<SliderHorizontal> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.3, initialPage: 1);
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        getMoreMovies();
        print('Se llamo');
      }
    });
    super.initState();
  }

  Future<void> getMoreMovies() async {
    final popularBloc = context.read<PopularBloc>();
    popularBloc.add(const PopularEventMovies());
  }

  @override
  void dispose() {
    _controller.dispose();
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
            controller: _controller,
            itemCount: widget.movies.length,
            itemBuilder: (_, i) {
              return SliderHorizontalItem(widget.movies[i]);
            },
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
