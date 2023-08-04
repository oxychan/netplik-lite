import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:next_starter/application/movie/movie_bloc.dart';
import 'package:next_starter/common/network/network_info.dart';
import 'package:next_starter/common/utils/title_utils.dart';
import 'package:next_starter/common/widgets/loading_indicator_widget.dart';
import 'package:next_starter/data/datasources/remote_datasources/movie_remote/movie_remote.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';
import 'package:next_starter/data/repositories/movie_repository.dart';
import 'package:next_starter/presentation/pages/movie/movie_page.dart';

class MockMovieRemote extends Mock implements MovieRemote {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockMovieBloc extends Mock implements MovieBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockMovieRemote mockMovieRemote;
  late MovieRepository movieRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MovieBloc movieBloc;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockMovieRemote = MockMovieRemote();
    movieRepository = MovieRepository(mockNetworkInfo, mockMovieRemote);
    movieBloc = MockMovieBloc();
  });

  final movieFromRemote = [
    MovieModel(
      id: "inception",
      title: "Inception",
      type: Type.MOVIE,
      posterImg: PosterImg.HTTPS_UNDEFINED,
      rating: "8.8",
      url: "https://example.com/inception",
      qualityResolution: QualityResolution.HD,
      genres: ["Action", "Sci-Fi", "Thriller"],
    ),
    MovieModel(
      id: "the-shawshank-redemtion",
      title: "The Shawshank Redemption",
      type: Type.MOVIE,
      posterImg: PosterImg.HTTPS_UNDEFINED,
      rating: "9.3",
      url: "https://example.com/shawshank-redemption",
      qualityResolution: QualityResolution.HD,
      genres: ["Drama"],
    ),
  ];

  testWidgets('home page showed loding indicator and movies data',
      (tester) async {
    final controller = StreamController<MovieState>();

    when(movieBloc.stream).thenAnswer((_) => controller.stream);

    controller.add(const MovieState(status: MovieStatus.initial));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MovieBloc>.value(
          value: movieBloc,
          child: const MovieView(),
        ),
      ),
    );

    expect(find.byType(LoadingIndicatorWidget), findsOneWidget);

    Future.delayed(const Duration(seconds: 2));

    controller
        .add(MovieState(status: MovieStatus.success, movies: movieFromRemote));

    await tester.pump();

    for (MovieModel movie in movieFromRemote) {
      expect(find.text(TitleUtils.idToTitle(movie.id!)), findsOneWidget);
    }
  });
}
