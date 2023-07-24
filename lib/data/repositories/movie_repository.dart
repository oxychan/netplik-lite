import 'package:injectable/injectable.dart';
import 'package:next_starter/common/base/base_repository.dart';
import 'package:next_starter/common/typedefs/typedefs.dart';
import 'package:next_starter/data/datasources/remote_datasources/movie_remote/movie_remote.dart';
import 'package:next_starter/data/models/movie/movie_detail_model.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';

import '../models/movie/movie_stream_model.dart';

@LazySingleton()
class MovieRepository extends BaseRepository {
  MovieRepository(super.networkInfo, this.remote);

  final MovieRemote remote;

  EitherResponse<List<MovieModel>> getMovies(int page) {
    return handleNetworkCall(
      call: remote.getMovies(page),
      onSuccess: (r) => r,
    );
  }

  EitherResponse<MovieDetailModel> getMovie(String movieId) {
    return handleNetworkCall(
      call: remote.getMovie(movieId),
      onSuccess: (r) => r,
    );
  }

  EitherResponse<List<MovieStreamModel>> streamMovie(String movieId) {
    return handleNetworkCall(
      call: remote.streamMovie(movieId),
      onSuccess: (r) => r,
    );
  }

  EitherResponse<List<MovieModel>> searchMovies(String movieTitle) {
    return handleNetworkCall(
      call: remote.searchMovies(movieTitle),
      onSuccess: (r) => r,
    );
  }
}
