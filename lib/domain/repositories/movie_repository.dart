import 'package:dartz/dartz.dart';
import 'package:movie_tracker/core/failures/failure.dart';
import 'package:movie_tracker/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<ServerFailure, List<Movie>>> getTrendingMovies();
  Future<Either<ServerFailure, List<Movie>>> searchMovies(String query);
  Future<Either<ServerFailure, List<Movie>>> getPopularMovies();
}
