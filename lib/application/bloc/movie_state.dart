part of 'movie_bloc.dart';

enum MovieStatus { initial, success, failure }

class MovieState extends Equatable {
  final MovieStatus status;
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final String errorMessage;

  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const <MovieModel>[],
    this.hasReachedMax = false,
    this.errorMessage = "",
  });

  MovieState copyWith({
    MovieStatus? status,
    List<MovieModel>? movies,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        hasReachedMax,
      ];
}
