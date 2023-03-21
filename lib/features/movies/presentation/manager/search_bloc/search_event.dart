part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventMovies extends SearchEvent {
  final String query;

  const SearchEventMovies(this.query);

  @override
  List<Object> get props => [query];
}
