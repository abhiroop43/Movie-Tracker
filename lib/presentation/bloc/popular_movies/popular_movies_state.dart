part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState {}

class PopularMoviesInitialState extends PopularMoviesState {}

class PopularMoviesLoadingState extends PopularMoviesState {}

class PopularMoviesLoadedState extends PopularMoviesState {
  final List<Movie> movies;

  PopularMoviesLoadedState(this.movies);
}

class PopularMoviesErrorState extends PopularMoviesState {
  final String message;

  PopularMoviesErrorState(this.message);
}
