import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:next_starter/data/models/movie/movie_detail_model.dart';
import 'package:next_starter/data/models/movie/movie_stream_model.dart';
import 'package:next_starter/data/repositories/movie_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

@injectable
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository repository;

  MovieDetailBloc(this.repository) : super(const MovieDetailState()) {
    on<FetchMoviesById>(_onMoviesFetchById);
    on<StreamMovie>(_onMovieStreams);
  }

  FutureOr<void> _onMoviesFetchById(
      FetchMoviesById event, Emitter<MovieDetailState> emit) async {
    final movie = await repository.getMovie(event.movieId);

    movie.fold(
      (l) => emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: MovieDetailStatus.success,
          movie: r,
        ),
      ),
    );
  }

  FutureOr<void> _onMovieStreams(
      StreamMovie event, Emitter<MovieDetailState> emit) async {
    final streams = await repository.streamMovie(event.movieId);

    streams.fold(
      (l) => emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: MovieDetailStatus.success,
            streams: List.of(state.streams ?? [])..addAll(r),
          ),
        );
      },
    );
  }
}
