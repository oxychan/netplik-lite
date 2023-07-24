part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String title;

  const SearchMovies(this.title);
}
