import 'package:dartz/dartz.dart';
import 'package:movie_tracker/core/failures/failure.dart';
import 'package:movie_tracker/domain/entities/movie.dart';
import 'package:movie_tracker/domain/repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;

  GetTrendingMovies(this.repository);

  Future<Either<ServerFailure, List<Movie>>> call() async {
    return repository.getTrendingMovies();
  }
}
