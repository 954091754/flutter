import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import '../models/movie.dart';

class MovieService {
  // Load movies from a local JSON asset. This is synchronous from caller's
  // point of view (returns Future<List<Movie>>).
  Future<List<Movie>> loadLocalMovies({String assetPath = 'assets/data/movies.json'}) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((e) => Movie.fromJson(e as Map<String, dynamic>)).toList();
  }
}
