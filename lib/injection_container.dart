import 'package:get_it/get_it.dart';
import 'package:movie_tracker/data/datasources/movie_remote_data_source.dart';
import 'package:movie_tracker/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:movie_tracker/data/repositories/movie_repository_impl.dart';
import 'package:movie_tracker/domain/repositories/movie_repository.dart';
import 'package:movie_tracker/domain/usecases/get_popular_movies.dart';
import 'package:movie_tracker/domain/usecases/get_trending_movies.dart';
import 'package:movie_tracker/domain/usecases/search_movies.dart';
import 'package:movie_tracker/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_tracker/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_tracker/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void init() {
  // bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));

  // use cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));

  // repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: getIt()),
  );

  // data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: getIt()),
  );

  // http service
  getIt.registerLazySingleton(() => http.Client());
}
