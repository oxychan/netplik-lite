import 'package:next_starter/data/models/movie/moview_model.dart';

abstract class MovieRemote {
  Future<List<MovieModel>> getMovies();
}
