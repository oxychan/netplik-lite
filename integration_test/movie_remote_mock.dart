import 'package:mockito/mockito.dart';
import 'package:next_starter/data/datasources/remote_datasources/movie_remote/movie_remote.dart';
import 'package:next_starter/data/models/movie/movie_detail_model.dart';
import 'package:next_starter/data/models/movie/movie_stream_model.dart';
import 'package:next_starter/data/models/movie/moview_model.dart';

class MockMovieRemote extends Mock implements MovieRemote {
  @override
  Future<List<MovieModel>> getMovies(int page) async {
    // Return your mock data for getMovies
    return Future.value(
      <MovieModel>[
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
        MovieModel(
          id: "3",
          title: "Interstellar",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "8.6",
          url: "https://example.com/interstellar",
          qualityResolution: QualityResolution.HD,
          genres: ["Adventure", "Drama", "Sci-Fi"],
        ),
        MovieModel(
          id: "4",
          title: "The Dark Knight",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "9.0",
          url: "https://example.com/dark-knight",
          qualityResolution: QualityResolution.HD,
          genres: ["Action", "Crime", "Drama"],
        ),
        MovieModel(
          id: "5",
          title: "The Godfather",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "9.2",
          url: "https://example.com/the-godfather",
          qualityResolution: QualityResolution.HD,
          genres: ["Crime", "Drama"],
        ),
        MovieModel(
          id: "6",
          title: "Pulp Fiction",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "8.9",
          url: "https://example.com/pulp-fiction",
          qualityResolution: QualityResolution.HD,
          genres: ["Crime", "Drama"],
        ),
        MovieModel(
          id: "7",
          title: "Forrest Gump",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "8.8",
          url: "https://example.com/forrest-gump",
          qualityResolution: QualityResolution.HD,
          genres: ["Drama", "Romance"],
        ),
        MovieModel(
          id: "8",
          title: "The Matrix",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "8.7",
          url: "https://example.com/the-matrix",
          qualityResolution: QualityResolution.HD,
          genres: ["Action", "Sci-Fi"],
        ),
        MovieModel(
          id: "9",
          title: "Gladiator",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "8.5",
          url: "https://example.com/gladiator",
          qualityResolution: QualityResolution.HD,
          genres: ["Action", "Adventure", "Drama"],
        ),
        MovieModel(
          id: "10",
          title: "The Lord of the Rings: The Return of the King",
          type: Type.MOVIE,
          posterImg: PosterImg.HTTPS_UNDEFINED,
          rating: "8.9",
          url: "https://example.com/lotr-return-of-the-king",
          qualityResolution: QualityResolution.HD,
          genres: ["Action", "Adventure", "Drama", "Fantasy"],
        ),
      ],
    );
  }

  @override
  Future<MovieDetailModel> getMovie(String movieId) async {
    return MovieDetailModel(
      id: "12345",
      title: "The Avengers",
      type: "movie",
      posterImg: "https://example.com/posters/the-avengers.jpg",
      quality: "HD",
      rating: "8.0",
      releaseDate: "2022-07-15",
      duration: "2h 23m",
      synopsis:
          "The Avengers must assemble once again to face a powerful new threat that could destroy the world.",
      trailerUrl: "https://example.com/trailers/the-avengers",
      genres: ["Action", "Adventure", "Sci-Fi"],
      directors: ["Joss Whedon"],
      countries: ["USA"],
      casts: ["Robert Downey Jr.", "Chris Evans", "Scarlett Johansson"],
      streams: [],
    );
  }

  @override
  Future<List<MovieStreamModel>> streamMovie(String movieId) async {
    // Return your mock data for streamMovie
    return <MovieStreamModel>[
      MovieStreamModel(
        provider: "Netflix",
        url: "https://example.com/stream/netflix/the-avengers",
        resolutions: ["HD", "4K"],
      ),
      MovieStreamModel(
        provider: "Amazon Prime Video",
        url: "https://example.com/stream/amazon/the-avengers",
        resolutions: ["HD"],
      ),
      MovieStreamModel(
        provider: "Disney+",
        url: "https://example.com/stream/disney/the-avengers",
        resolutions: ["HD", "UltraHD"],
      ),
    ];
  }

  @override
  Future<List<MovieModel>> searchMovies(String movieTitle) async {
    List<MovieModel> data = [
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
      MovieModel(
        id: "3",
        title: "Interstellar",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "8.6",
        url: "https://example.com/interstellar",
        qualityResolution: QualityResolution.HD,
        genres: ["Adventure", "Drama", "Sci-Fi"],
      ),
      MovieModel(
        id: "4",
        title: "The Dark Knight",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "9.0",
        url: "https://example.com/dark-knight",
        qualityResolution: QualityResolution.HD,
        genres: ["Action", "Crime", "Drama"],
      ),
      MovieModel(
        id: "5",
        title: "The Godfather",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "9.2",
        url: "https://example.com/the-godfather",
        qualityResolution: QualityResolution.HD,
        genres: ["Crime", "Drama"],
      ),
      MovieModel(
        id: "6",
        title: "Pulp Fiction",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "8.9",
        url: "https://example.com/pulp-fiction",
        qualityResolution: QualityResolution.HD,
        genres: ["Crime", "Drama"],
      ),
      MovieModel(
        id: "7",
        title: "Forrest Gump",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "8.8",
        url: "https://example.com/forrest-gump",
        qualityResolution: QualityResolution.HD,
        genres: ["Drama", "Romance"],
      ),
      MovieModel(
        id: "8",
        title: "The Matrix",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "8.7",
        url: "https://example.com/the-matrix",
        qualityResolution: QualityResolution.HD,
        genres: ["Action", "Sci-Fi"],
      ),
      MovieModel(
        id: "9",
        title: "Gladiator",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "8.5",
        url: "https://example.com/gladiator",
        qualityResolution: QualityResolution.HD,
        genres: ["Action", "Adventure", "Drama"],
      ),
      MovieModel(
        id: "10",
        title: "The Lord of the Rings: The Return of the King",
        type: Type.MOVIE,
        posterImg: PosterImg.HTTPS_UNDEFINED,
        rating: "8.9",
        url: "https://example.com/lotr-return-of-the-king",
        qualityResolution: QualityResolution.HD,
        genres: ["Action", "Adventure", "Drama", "Fantasy"],
      ),
    ];
    return data.where((movie) => movie.title == movieTitle).toList();
  }
}
