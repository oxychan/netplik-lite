import 'package:injectable/injectable.dart';
import 'package:next_starter/common/base/base_dio_remote_source.dart';
import 'package:next_starter/common/logging/logger.dart';
import 'package:next_starter/common/utils/api_path.dart';
import 'package:next_starter/data/models/movie/movie_detail_model.dart';
import 'package:next_starter/data/models/movie/movie_stream_model.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';

import 'movie_remote.dart';

@LazySingleton(as: MovieRemote)
class MovieRemoteImpl extends BaseDioRemoteSource implements MovieRemote {
  MovieRemoteImpl(super.dio, super.session);

  @override
  Future<List<MovieModel>> getMovies() {
    return networkRequest(
      request: (dio) => dio.get(ApiPath.movies, queryParameters: {
        'page': 8,
      }),
      onResponse: (json) => (json as List)
          .map<MovieModel>((movie) => MovieModel.fromJson(movie))
          .toList(),
    );
  }

  @override
  Future<MovieDetailModel> getMovie(String movieId) {
    return networkRequest(
      request: (dio) => dio.get("${ApiPath.movies}/$movieId"),
      onResponse: (json) {
        logger.d(json);
        return MovieDetailModel.fromJson(json);
      },
    );
  }

  @override
  Future<List<MovieStreamModel>> streamMovie(String movieId) {
    return networkRequest(
      request: (dio) => dio.get("${ApiPath.movies}/$movieId/streams"),
      onResponse: (json) => (json as List)
          .map<MovieStreamModel>(
            (stream) => MovieStreamModel.fromJson(stream),
          )
          .toList(),
    );
  }

  @override
  Future<List<MovieModel>> searchMovies(String movieTitle) {
    return networkRequest(
      request: (dio) => dio.get("/search/$movieTitle"),
      onResponse: (json) => (json as List)
          .map<MovieModel>((movie) => MovieModel.fromJson(movie))
          .toList(),
    );
  }
}
