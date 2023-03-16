part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();
}

class PopularEventMovies extends PopularEvent {
  const PopularEventMovies();

  @override
  List<Object?> get props => [];
}
