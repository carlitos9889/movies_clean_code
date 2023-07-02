import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/const_app.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:palette_generator/palette_generator.dart';

class Carousel extends StatefulWidget {
  const Carousel(this.movies, this.onTap, {Key? key}) : super(key: key);
  final List<MovieEntity> movies;
  final void Function(MovieEntity movie, String tag) onTap;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PaletteGenerator? paletteGenerator;
  Color? dominante = Colors.white;
  Color? vibrant = Colors.white;

  @override
  void initState() {
    getImagePalette(CachedNetworkImageProvider(
      '${ConstApp.urlImage}${widget.movies[0].poster_path}',
    ));

    super.initState();
  }

  Future<void> getImagePalette(ImageProvider imageProvider) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    setState(() {
      if (paletteGenerator != null) {
        dominante = paletteGenerator!.dominantColor != null
            ? paletteGenerator!.dominantColor!.color
            : Colors.white;
        vibrant = paletteGenerator!.vibrantColor != null
            ? paletteGenerator!.vibrantColor!.color
            : Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.transparent,
                dominante ?? Colors.white,
                vibrant ?? Colors.white,
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 30),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Swiper(
            curve: Curves.ease,
            onIndexChanged: (i) {
              setState(() {
                getImagePalette(CachedNetworkImageProvider(
                  '${ConstApp.urlImage}${widget.movies[i].poster_path}',
                ));
              });
            },
            itemBuilder: (_, i) {
              final movie = widget.movies[i];
              final onTap = widget.onTap;
              return CarouselItem(movie, onTap);
            },
            itemCount: widget.movies.length,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        ),
      ],
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem(this.movie, this.onTap, {Key? key}) : super(key: key);

  final MovieEntity movie;
  final void Function(MovieEntity movie, String tag) onTap;

  @override
  Widget build(BuildContext context) {
    final tag = '${movie.id}now_playing';
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black38, blurRadius: 13, offset: Offset(0, 10)),
      ],
    );
    return GestureDetector(
      onTap: () => onTap(movie, tag),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 100,
              placeholder: AssetImage(ConstApp.placeholder),
              image: CachedNetworkImageProvider(
                '${ConstApp.urlImage}${movie.poster_path}',
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
