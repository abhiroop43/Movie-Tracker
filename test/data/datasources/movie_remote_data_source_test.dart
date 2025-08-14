import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tracker/core/exceptions/server_exception.dart';
import 'package:movie_tracker/data/datasources/movie_remote_data_source.dart';
import 'package:movie_tracker/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:movie_tracker/env.dart';

import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MovieRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  final String baseUrl = "https://api.themoviedb.org/3";
  final String searchParam = "Friday The 13th";
  final String apiKey = Env.tmdbApiKey;

  final trendingUrl = "$baseUrl/trending/movie/day?api_key=$apiKey";
  final popularUrl = "$baseUrl/movie/popular?api_key=$apiKey";
  final searchUrl = "$baseUrl/search/movie?query=$searchParam&api_key=$apiKey";

  const String sampleApiResponse = '''
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/path.jpg",
              "id": 1,
              "title": "Sample Movie",
              "original_language": "en",
              "original_title": "Sample Movie",
              "overview": "Overview here",
              "poster_path": "/path2.jpg",
              "media_type": "movie",
              "genre_ids": [1, 2, 3],
              "popularity": 100.0,
              "release_date": "2020-01-01",
              "video": false,
              "vote_average": 7.5,
              "vote_count": 100
            }
          ],
          "total_pages": 1,
          "total_results": 1
        }
        ''';

  test(
    "should perform a GET request on a URL to get the trending movies",
    () async {
      // arrnage
      when(
        mockHttpClient.get(Uri.parse(trendingUrl)),
      ).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

      // act
      await dataSource.getTrendingMovies();

      // assert
      verify(mockHttpClient.get(Uri.parse(trendingUrl)));
    },
  );

  test(
    "should perform a GET request on a URL to get the popular movies",
    () async {
      // arrnage
      when(
        mockHttpClient.get(Uri.parse(popularUrl)),
      ).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

      // act
      await dataSource.getPopularMovies();

      // assert
      verify(mockHttpClient.get(Uri.parse(popularUrl)));
    },
  );

  test("should perform a GET request on a URL to search for movies", () async {
    // arrnage
    when(
      mockHttpClient.get(Uri.parse(searchUrl)),
    ).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // act
    await dataSource.searchMovies(searchParam);

    // assert
    verify(mockHttpClient.get(Uri.parse(searchUrl)));
  });

  test(
    "should throw ServerException when response status code is not 200",
    () async {
      // arrnage
      when(
        mockHttpClient.get(any),
      ).thenAnswer((_) async => http.Response("Something went wrong", 500));

      // act
      final call = dataSource.getTrendingMovies;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    },
  );
}
