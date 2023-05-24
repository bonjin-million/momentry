import 'package:momentry/models/movie/movie.dart';

class MovieResponse {
  final int total;
  final List<Movie> items;

  MovieResponse({
    required this.total,
    required this.items,
  });

  MovieResponse.fromJson(Map<String, dynamic> json)
      : total = json['TotalCount'],
        items = json['Data'][0]['Result'] != null
            ? (json['Data'][0]['Result'] as List)
                .map((e) => Movie.fromJson(e))
                .toList()
            : [];
}
