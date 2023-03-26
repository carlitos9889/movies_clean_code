import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/const_app.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/presentation/manager/nowplaying_bloc/nowplaying_bloc.dart';
import 'package:movies/features/movies/presentation/pages/movie/movie_page.dart';
import 'package:movies/features/movies/presentation/widgets/loading_widget.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<NowplayingBloc, NowplayingState>(
      buildWhen: (oldState, newState) => oldState != newState,
      builder: (context, state) => state.when(
        loading: () => LoadingWidget(height: size.height * 0.5),
        success: (movies) => CarouselView(movies),
        failure: (message) => Text(message),
      ),
    );
  }
}

class CarouselView extends StatelessWidget {
  const CarouselView(this.movies, {Key? key}) : super(key: key);
  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Swiper(
        curve: Curves.ease,
        itemBuilder: (_, i) => CarouselItem(movies[i]),
        itemCount: movies.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem(this.movie, {Key? key}) : super(key: key);

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    final tag = '${movie.id}now_playing';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MoviePage.routeName,
          arguments: [movie, tag],
        );
      },
      child: Hero(
        tag: tag,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 100,
              placeholder: AssetImage(ConstApp.placeholder),
              image: CachedNetworkImageProvider(
                '${ConstApp.urlImage}${movie.poster_path}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
