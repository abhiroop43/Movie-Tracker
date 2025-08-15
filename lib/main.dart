import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/injection_container.dart';
import 'package:movie_tracker/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_tracker/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_tracker/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_tracker/presentation/pages/home_screen.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<PopularMoviesBloc>()..add(FetchPopularMoviesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                getIt<TrendingMoviesBloc>()..add(FetchTrendingMoviesEvent()),
          ),
          BlocProvider(create: (context) => getIt<SearchMoviesBloc>()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
