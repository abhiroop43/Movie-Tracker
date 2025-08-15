import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_tracker/domain/entities/movie.dart';
import 'package:movie_tracker/domain/usecases/get_trending_movies.dart';

part 'trending_movies_event.dart';
part 'trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingMoviesBloc({required this.getTrendingMovies})
    : super(TrendingMoviesInitialState()) {
    on<FetchTrendingMoviesEvent>(fetchTrendingMoviesEventHandler);
  }

  FutureOr<void> fetchTrendingMoviesEventHandler(
    FetchTrendingMoviesEvent event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    emit(TrendingMoviesLoadingState());

    final failureOrMovies = await getTrendingMovies();

    failureOrMovies.fold(
      (failure) => emit(TrendingMoviesErrorState(failure.toString())),
      (movies) => emit(TrendingMoviesLoadedState(movies)),
    );
  }
}
