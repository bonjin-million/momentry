import 'dart:convert';

class MovieDetail {
  final int id;
  final int movieId;
  final String title;
  final String image;
  final List<bool> stars;
  final String content;
  final String? date;
  final String prodYear; // 제작년도
  final String actors;
  final String directors;
  final String type;

  MovieDetail({
    required this.id,
    required this.movieId,
    required this.title,
    required this.image,
    required this.stars,
    required this.content,
    required this.date,
    required this.prodYear,
    required this.actors,
    required this.directors,
    required this.type,
  });

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        movieId = json['movieId'],
        content = json['content'],
        date = json['date'],
        stars = List<bool>.from(jsonDecode(json['stars'])),
        image = json['image'],
        prodYear = json['prodYear'],
        actors = json['actors'],
        directors = json['directors'],
        type = json['type'];

  MovieDetail.fromApiJson(Map<String, dynamic> json)
      : id = 0,
        title = json['title'],
        movieId = json['id'],
        content = '',
        date = '',
        stars = [false],
        image = 'https://image.tmdb.org/t/p/w200' + json['poster_path'],
        prodYear = json['release_date'],
        actors = '',
        directors = '',
        type = '';

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'movieId': movieId,
        'image': image,
        'stars': stars,
        'content': content,
        'date': date,
        'prodYear': prodYear,
        'actors': actors,
        'directors': directors,
        'type': type,
      };
}
