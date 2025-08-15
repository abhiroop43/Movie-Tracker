import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_tracker/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_tracker/presentation/pages/movies_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final bckImage =
      'https://w0.peakpx.com/wallpaper/732/875/HD-wallpaper-anonymous-black-cool-dark-guy-foux-hacker-scary-tech.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Wojak 👋',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Text(
              'Anonymouse Movie Tracker',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Default Image
                Container(
                  height: 290,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(bckImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ), // Border radius
                                ),
                              ),
                              child: Text('➡ Login'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Trending Movies
                Text(
                  'Trending Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
                  builder: (context, state) {
                    if (state is TrendingMoviesLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is TrendingMoviesLoadedState) {
                      return MoviesList(movies: state.movies);
                    } else if (state is TrendingMoviesErrorState) {
                      return Text(state.message);
                    }
                    return Container();
                  },
                ),

                SizedBox(height: 20),
                // Popular Movies
                Text(
                  'Popular Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                    if (state is PopularMoviesLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is PopularMoviesLoadedState) {
                      return MoviesList(movies: state.movies);
                    } else if (state is PopularMoviesErrorState) {
                      return Text(state.message);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
