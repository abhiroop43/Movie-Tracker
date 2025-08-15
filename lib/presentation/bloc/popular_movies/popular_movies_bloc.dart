import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_tracker/domain/entities/movie.dart';
import 'package:movie_tracker/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
    : super(PopularMoviesInitialState()) {
    on<FetchPopularMoviesEvent>(fetchPopularMoviesEventHandler);
  }

  FutureOr<void> fetchPopularMoviesEventHandler(
    FetchPopularMoviesEvent event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoadingState());

    final failureOrMovies = await getPopularMovies();

    failureOrMovies.fold(
      (failure) => emit(PopularMoviesErrorState(failure.toString())),
      (movies) => emit(PopularMoviesLoadedState(movies)),
    );
  }
}
