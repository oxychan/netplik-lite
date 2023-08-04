import 'dart:ffi';

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

import 'movie_remote_mock.dart';
import 'network_info_mock.dart';

class MockMovieBloc extends Mock implements MovieBloc {}

// Define a class to mock the MovieRemote
class MockMovieRemote extends Mock implements MovieRemote {}

// Define a class to mock the NetworkInfo
class MockNetworkInfo extends Mock implements NetworkInfo {}

// Instance of your service locator
final sl = GetIt.instance;

// Initialize the service locator
void setUpServiceLocator() {
  // Unregister all instances before running each test
  sl.allowReassignment = true;

  // Mock the needed services
  var movieRemote = MockMovieRemote();
  var networkInfo = MockNetworkInfo();

  // Register the services
  sl.registerLazySingleton<MovieRemote>(() => movieRemote);
  sl.registerLazySingleton<NetworkInfo>(() => networkInfo);

  // Instantiate and register the repository
  var movieRepository = MovieRepository(networkInfo, movieRemote);
  sl.registerLazySingleton<MovieRepository>(() => movieRepository);

  // Instantiate and register the bloc
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
      // Get the MockMovieRemote from the service locator
      MockMovieRemote movieRemote = sl.get<MovieRemote>() as MockMovieRemote;

      // Specify that the getMovies method should return a list of MovieModel
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

      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => sl<MovieBloc>(),
            child: const MovieView(),
          ),
        ),
        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider<MovieBloc>(
        //       create: (context) => sl<MovieBloc>(),
        //     ),
        //   ],
        //   child: MaterialApp(home: MoviePage()),
        // ),
      );

      // Trigger a frame
      await tester.pumpAndSettle();

      // Verify that list of movies are shown
      expect(find.byType(MovieCard), findsNWidgets(2));
    });
  });
}
