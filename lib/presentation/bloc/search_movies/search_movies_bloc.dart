import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_tracker/domain/entities/movie.dart';

import 'package:movie_tracker/domain/usecases/search_movies.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies})
    : super(SearchMoviesInitialState()) {
    on<FetchSearchedMoviesEvent>(fetchSearchedMoviesEventHandler);
  }

  FutureOr<void> fetchSearchedMoviesEventHandler(
    FetchSearchedMoviesEvent event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(SearchMoviesLoadingState());

    final failureOrMovies = await searchMovies(event.query);

    failureOrMovies.fold(
      (failure) => emit(SearchMoviesErrorState(failure.toString())),
      (movies) => emit(SearchMoviesLoadedState(movies)),
    );
  }
}
