import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/presentation/manager/now_playing_bloc/now_playing_bloc.dart';
import 'package:movies/features/movies/presentation/widgets/loading_widget.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      buildWhen: (oldState, newState) {
        return oldState != newState;
      },
      builder: (context, state) {
        if (state is NowPlayingLoading) {
          return LoadingWidget(
            height: MediaQuery.of(context).size.height * 0.5,
          );
        }
        if (state is NowPlayingFailure) {
          return Text(state.errorMsg);
        }
        return CarouselView(state.movies);
      },
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
        autoplay: true,
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          height: 100,
          placeholder: const AssetImage('assets/img.jpg'),
          image: CachedNetworkImageProvider(
            'https://image.tmdb.org/t/p/w500${movie.poster_path}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
