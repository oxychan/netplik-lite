import 'package:injectable/injectable.dart';
import 'package:next_starter/common/base/base_repository.dart';
import 'package:next_starter/common/typedefs/typedefs.dart';
import 'package:next_starter/data/datasources/remote_datasources/movie_remote/movie_remote.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';

@LazySingleton()
class MovieRepository extends BaseRepository {
  MovieRepository(super.networkInfo, this.remote);

  final MovieRemote remote;

  EitherResponse<List<MovieModel>> getMovies() {
    return handleNetworkCall(
      call: remote.getMovies(),
      onSuccess: (r) => r,
    );
  }
}
