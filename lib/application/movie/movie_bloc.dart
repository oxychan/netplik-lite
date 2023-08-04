import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:next_starter/common/logging/logger.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';
import 'package:next_starter/data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(const MovieState()) {
    on<FetchMovies>(_onMoviesFetc);
    on<SearchMovies>(_onMoviesSearch);
  }

  FutureOr<void> _onMoviesFetc(
      FetchMovies event, Emitter<MovieState> emit) async {
    if (state.hasReachedMax) return;

    final movies = await repository.getMovies(event.page);
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

  FutureOr<void> _onMoviesSearch(
      SearchMovies event, Emitter<MovieState> emit) async {
    if (state.hasReachedMax) return;

    final movies = await repository.searchMovies(event.title);
    logger.d(movies);
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
