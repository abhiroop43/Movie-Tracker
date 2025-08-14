import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_tracker/core/exceptions/server_exception.dart';
import 'package:movie_tracker/data/datasources/movie_remote_data_source.dart';
import 'package:movie_tracker/data/models/movie_model.dart';
import 'package:movie_tracker/env.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  static const _baseUrl = "https://api.themoviedb.org/3";
  static final _apiKey = Env.tmdbApiKey;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse("$_baseUrl/movie/popular?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody["results"] as List)
          .map((movie) => MovieModel.fromMap(movie))
          .toList();

      return movies;
    }

    throw ServerException();
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client.get(
      Uri.parse("$_baseUrl/trending/movie/day?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody["results"] as List)
          .map((movie) => MovieModel.fromMap(movie))
          .toList();

      return movies;
    }

    throw ServerException();
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(
      Uri.parse("$_baseUrl/search/movie?query=$query&api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody["results"] as List)
          .map((movie) => MovieModel.fromMap(movie))
          .toList();

      return movies;
    }

    throw ServerException();
  }
}
