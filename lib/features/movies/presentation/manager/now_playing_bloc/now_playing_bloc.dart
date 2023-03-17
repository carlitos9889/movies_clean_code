import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/use_cases/use_cases.dart';
import 'package:movies/features/movies/domain/entities/movie_entity.dart';
import 'package:movies/features/movies/domain/use_cases/now_playing_use_case.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final NowPlayingUseCase useCase;
  int page = 0;
  bool isLoading = false;

  NowPlayingBloc(this.useCase) : super(const NowPlayingInitial([])) {
    on<NowPlayingEvent>((event, emit) async {
      if (event is NowPlayingEventMovies) {
        if (isLoading) return;
        isLoading = true;
        page++;
        if (page == 1) {
          emit(const NowPlayingLoading([]));
        }

        final failureOrMovies = await useCase(ParamPage(page.toString()));
        failureOrMovies.fold(
          (failure) => emit(
            const NowPlayingFailure([], 'Error to Load NowPlaying'),
          ),
          (movies) => emit(NowPlayingSuccess(movies)),
        );
        isLoading = false;
      }
    });
  }
}
