part of 'search_movies_bloc.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitialState extends SearchMoviesState {}

class SearchMoviesLoadingState extends SearchMoviesState {}

class SearchMoviesLoadedState extends SearchMoviesState {
  final List<Movie> movies;

  SearchMoviesLoadedState(this.movies);
}

class SearchMoviesErrorState extends SearchMoviesState {
  final String message;

  SearchMoviesErrorState(this.message);
}
