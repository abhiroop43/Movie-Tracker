import 'package:movie_tracker/domain/entities/movie.dart';
import 'package:movie_tracker/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<List<Movie>> call() {
    return repository.getPopularMovies();
  }
}
