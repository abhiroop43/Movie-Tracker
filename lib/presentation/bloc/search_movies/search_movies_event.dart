part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent {}

class FetchSearchedMoviesEvent extends SearchMoviesEvent {
  final String query;

  FetchSearchedMoviesEvent(this.query);
}
