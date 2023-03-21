import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/presentation/manager/search_bloc/search_bloc.dart';
import 'package:movies/features/movies/presentation/pages/movie/movie_page.dart';
import 'package:movies/features/movies/presentation/widgets/loading_widget.dart';

class SearchDelegateMovie extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    final action = query.isEmpty
        ? Container()
        : IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.clear),
          );
    return [action];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      context.read<SearchBloc>().add(SearchEventMovies(query));
      return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const LoadingWidget(height: 300);
          }
          if (state is SearchFailure) {
            return Text(state.errorMsg);
          }
          if (state is SearchSuccess) {
            return ListView.separated(
              itemCount: state.movies.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(state.movies[i].title),
                leading: Hero(
                  tag: state.movies[i].id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/img.jpg'),
                      image: CachedNetworkImageProvider(
                        'https://image.tmdb.org/t/p/w500${state.movies[i].poster_path}',
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MoviePage.routeName,
                    arguments: [state.movies[i], state.movies[i].id.toString()],
                  );
                },
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
          return Container();
        },
      );
    }
  }
}
