import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tracker/domain/entities/movie.dart';
import 'package:movie_tracker/domain/usecases/get_popular_movies.dart';

import 'get_trending_movie_test.mocks.dart';

void main() {
  late GetPopularMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRepository);
  });

  final pMovieList = [
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

  test("should get popular movies from the repository", () async {
    // arrange
    when(
      mockMovieRepository.getPopularMovies(),
    ).thenAnswer((_) async => Right(pMovieList));

    // act
    final result = await usecase();

    // assert
    expect(result, Right(pMovieList));
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
