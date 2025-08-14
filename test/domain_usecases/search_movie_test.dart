import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tracker/domain/entities/movie.dart';
import 'package:movie_tracker/domain/usecases/search_movies.dart';

import 'get_movie_test.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final query = "Friday the 13th";

  final searchedMovies = [
    Movie(
      id: 1,
      title: "Test Movie 1",
      overview: "Desc 1",
      posterPath: "/image1",
    ),
    Movie(
      id: 2,
      title: "Test Movie 2",
      overview: "Desc 2",
      posterPath: "/image2",
    ),
  ];

  test("should get movies matching the query input", () async {
    // arrange
    when(
      mockMovieRepository.searchMovies(any),
    ).thenAnswer((_) async => searchedMovies);

    // act
    final result = await usecase(query);

    // assert
    expect(result, searchedMovies);
    verify(mockMovieRepository.searchMovies(query));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
