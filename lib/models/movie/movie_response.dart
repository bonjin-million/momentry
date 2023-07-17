import 'package:momentry/models/movie/movie.dart';

class MovieResponse {
  final int page;
  final List<Movie> items;

  MovieResponse({
    required this.page,
    required this.items,
  });

  MovieResponse.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        items = json['results'] != null
            ? (json['results'] as List).map((e) => Movie.fromJson(e)).toList()
            : [];
}
