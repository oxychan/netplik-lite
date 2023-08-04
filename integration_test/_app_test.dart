import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:next_starter/application/movie/movie_bloc.dart';
import 'package:next_starter/common/network/network_info.dart';
import 'package:next_starter/data/datasources/remote_datasources/movie_remote/movie_remote.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';
import 'package:next_starter/data/repositories/movie_repository.dart';
import 'package:next_starter/presentation/components/card/movie_card.dart';
import 'package:next_starter/presentation/pages/movie/movie_page.dart';

class MockMovieBloc extends Mock implements MovieBloc {}

class MockMovieRemote extends Mock implements MovieRemote {
  List<MovieModel> mockedMovies;

  MockMovieRemote(this.mockedMovies);

  @override
  Future<List<MovieModel>> getMovies(int count) async {
    return mockedMovies;
  }
}

class MockNetworkInfo extends Mock implements NetworkInfo {}

final sl = GetIt.instance;

void setUpServiceLocator() {
  sl.allowReassignment = true;

  // Mock the needed services
  var movieRemote = MockMovieRemote([
    MovieModel(
      id: "1",
      title: "Inception",
      type: Type.MOVIE,
      posterImg: PosterImg.HTTPS_UNDEFINED,
      rating: "8.8",
      url: "https://example.com/inception",
      qualityResolution: QualityResolution.HD,
      genres: ["Action", "Sci-Fi", "Thriller"],
    ),
    MovieModel(
      id: "2",
      title: "The Shawshank Redemption",
      type: Type.MOVIE,
      posterImg: PosterImg.HTTPS_UNDEFINED,
      rating: "9.3",
      url: "https://example.com/shawshank-redemption",
      qualityResolution: QualityResolution.HD,
      genres: ["Drama"],
    ),
  ]);
  var networkInfo = MockNetworkInfo();

  sl.registerLazySingleton<MovieRemote>(() => movieRemote);
  sl.registerLazySingleton<NetworkInfo>(() => networkInfo);

  var movieRepository = MovieRepository(networkInfo, movieRemote);
  sl.registerLazySingleton<MovieRepository>(() => movieRepository);

  var movieBloc = MovieBloc(movieRepository);
  sl.registerLazySingleton<MovieBloc>(() => movieBloc);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    setUpServiceLocator();
  });

  group('home end to end test', () {
    testWidgets('home opened and correct number of movies is displayed',
        (tester) async {
      MockMovieRemote movieRemote = sl.get<MovieRemote>() as MockMovieRemote;

      when(movieRemote.getMovies(2)).thenAnswer((_) async => <MovieModel>[
            MovieModel(
              id: "1",
              title: "Inception",
              type: Type.MOVIE,
              posterImg: PosterImg.HTTPS_UNDEFINED,
              rating: "8.8",
              url: "https://example.com/inception",
              qualityResolution: QualityResolution.HD,
              genres: ["Action", "Sci-Fi", "Thriller"],
            ),
            MovieModel(
              id: "2",
              title: "The Shawshank Redemption",
              type: Type.MOVIE,
              posterImg: PosterImg.HTTPS_UNDEFINED,
              rating: "9.3",
              url: "https://example.com/shawshank-redemption",
              qualityResolution: QualityResolution.HD,
              genres: ["Drama"],
            ),
          ]);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => sl<MovieBloc>(),
            child: const MovieView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MovieCard), findsNWidgets(2));
    });
  });
}
