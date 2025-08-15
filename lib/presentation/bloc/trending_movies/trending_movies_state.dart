part of 'trending_movies_bloc.dart';

abstract class TrendingMoviesState {}

class TrendingMoviesInitialState extends TrendingMoviesState {}

class TrendingMoviesLoadingState extends TrendingMoviesState {}

class TrendingMoviesLoadedState extends TrendingMoviesState {
  final List<Movie> movies;

  TrendingMoviesLoadedState(this.movies);
}

class TrendingMoviesErrorState extends TrendingMoviesState {
  final String message;

  TrendingMoviesErrorState(this.message);
}
