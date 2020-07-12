import 'dart:async';
import 'package:tienda_mimi/PatternBLOC/models/ItemModel.dart';

import 'movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
}