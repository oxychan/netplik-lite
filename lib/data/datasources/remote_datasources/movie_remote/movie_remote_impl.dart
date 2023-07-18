import 'package:injectable/injectable.dart';
import 'package:next_starter/common/base/base_dio_remote_source.dart';
import 'package:next_starter/common/utils/api_path.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';

import 'movie_remote.dart';

@LazySingleton(as: MovieRemote)
class MovieRemoteImpl extends BaseDioRemoteSource implements MovieRemote {
  MovieRemoteImpl(super.dio, super.session);

  @override
  Future<List<MovieModel>> getMovies() {
    return networkRequest(
      request: (dio) => dio.get(ApiPath.movies),
      onResponse: (json) => (json as List)
          .map<MovieModel>((movie) => MovieModel.fromJson(movie))
          .toList(),
    );
  }
}
