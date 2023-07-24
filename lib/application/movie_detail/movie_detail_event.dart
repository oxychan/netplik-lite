part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesById extends MovieDetailEvent {
  final String movieId;

  const FetchMoviesById(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class StreamMovie extends MovieDetailEvent {
  final String movieId;

  const StreamMovie(this.movieId);

  @override
  List<Object> get props => [movieId];
}
