part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, success, failure }

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final MovieDetailModel? movie;
  final List<MovieStreamModel>? streams;
  final String errorMessage;

  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.movie,
    this.streams,
    this.errorMessage = "",
  });

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieDetailModel? movie,
    List<MovieStreamModel>? streams,
    String? errorMessage,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      streams: streams ?? this.streams,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movie,
        streams,
        errorMessage,
      ];
}
