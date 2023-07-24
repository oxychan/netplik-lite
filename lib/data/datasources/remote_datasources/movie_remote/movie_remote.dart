import 'package:next_starter/data/models/movie/movie_detail_model.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';

import '../../../models/movie/movie_stream_model.dart';

abstract class MovieRemote {
  Future<List<MovieModel>> getMovies(int page);
  Future<MovieDetailModel> getMovie(String movieId);
  Future<List<MovieStreamModel>> streamMovie(String movieId);
  Future<List<MovieModel>> searchMovies(String movieTitle);
}
