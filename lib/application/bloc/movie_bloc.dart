import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';
import 'package:next_starter/data/repositories/movie_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_event.dart';
part 'movie_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (event, mapper) {
    return droppable<E>().call(event.throttle(duration), mapper);
  };
}

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(const MovieState()) {
    on<FetchMovies>(_onMoviesFetc);
  }

  FutureOr<void> _onMoviesFetc(
      FetchMovies event, Emitter<MovieState> emit) async {
    if (state.hasReachedMax) return;

    final movies = await repository.getMovies();
    movies.fold(
      (l) => emit(
        state.copyWith(
          status: MovieStatus.failure,
          errorMessage: l.message,
        ),
      ),
      (r) {
        emit(
          r.length < 10
              ? state.copyWith(
                  status: MovieStatus.success,
                  hasReachedMax: true,
                )
              : state.copyWith(
                  status: MovieStatus.success,
                  movies: List.of(state.movies)..addAll(r),
                  hasReachedMax: false,
                ),
        );
      },
    );
  }
}
