import 'dart:convert';

import 'movie.dart';

class MovieDetail {
  final int id;
  final String title;
  final String image;
  final List<bool> stars;
  final String content;
  final String date;
  final String prodYear; // 제작년도
  final List<MovieActor> actors;
  final List<MovieDirector> directors;

  MovieDetail(
      {required this.id,
      required this.title,
      required this.image,
      required this.stars,
      required this.content,
      required this.date,
      required this.prodYear,
      required this.actors,
      required this.directors});

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = json['date'],
        stars = List<bool>.from(jsonDecode(json['stars'])),
        image = json['image'],
        prodYear = json['prodYear'],
        actors = List<MovieActor>.from(jsonDecode(json['actors'])
            .map((e) => MovieActor.fromJson(e))
            .toList()),
        directors = List<MovieDirector>.from(jsonDecode(json['directors'])
            .map((e) => MovieDirector.fromJson(e))
            .toList());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'image': image,
        'stars': stars,
        'content': content,
        'date': date,
        'prodYear': prodYear,
        'actors': actors,
        'directors': directors,
      };
}
