import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tracker/core/exceptions/server_exception.dart';
import 'package:movie_tracker/core/failures/failure.dart';
import 'package:movie_tracker/data/datasources/movie_remote_data_source.dart';
import 'package:movie_tracker/data/models/movie_model.dart';
import 'package:movie_tracker/data/repositories/movie_repository_impl.dart';
import 'package:movie_tracker/domain/entities/movie.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])
void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource,
    );
  });

  final String query = "Friday the 13th";

  final movieModelsList = [
    MovieModel(
      id: 1,
      title: "Test Movie 1",
      overview: "Desc 1",
      posterPath: "/image1",
    ),
    MovieModel(
      id: 2,
      title: "Test Movie 2",
      overview: "Desc 2",
      posterPath: "/image2",
    ),
  ];

  test("should get trending movies from the remote data source", () async {
    when(
      mockMovieRemoteDataSource.getTrendingMovies(),
    ).thenAnswer((_) async => movieModelsList);

    final result = await repository.getTrendingMovies();

    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<ServerFailure, List<Movie>>>());
  });

  test("should get popular movies from the remote data source", () async {
    when(
      mockMovieRemoteDataSource.getPopularMovies(),
    ).thenAnswer((_) async => movieModelsList);

    final result = await repository.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<ServerFailure, List<Movie>>>());
  });

  test("should search movies from the remote data source", () async {
    when(
      mockMovieRemoteDataSource.searchMovies(any),
    ).thenAnswer((_) async => movieModelsList);

    final result = await repository.searchMovies(query);

    verify(mockMovieRemoteDataSource.searchMovies(query));
    expect(result, isA<Right<ServerFailure, List<Movie>>>());
  });

  test(
    "should return ServerException when the call to getTrendingMovies is unsuccessful",
    () async {
      when(
        mockMovieRemoteDataSource.getTrendingMovies(),
      ).thenThrow(ServerException());

      final result = await repository.getTrendingMovies();

      expect(result, isA<Left<ServerFailure, List<Movie>>>());
    },
  );

  test(
    "should return ServerException when the call to searchMovies is unsuccessful",
    () async {
      when(
        mockMovieRemoteDataSource.searchMovies(any),
      ).thenThrow(ServerException());

      final result = await repository.searchMovies(query);

      expect(result, isA<Left<ServerFailure, List<Movie>>>());
    },
  );
}
