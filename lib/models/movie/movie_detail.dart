import 'dart:convert';

class MovieDetail {
  final int id;
  final String title;
  final String image;
  final List<dynamic> stars;
  final String author;
  final String publisher;
  final String content;
  final String date;

  MovieDetail(
      {required this.id,
      required this.title,
      required this.image,
      required this.stars,
      required this.author,
      required this.publisher,
      required this.content,
      required this.date});

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = json['date'],
        publisher = json['publisher'],
        author = json['author'],
        stars = jsonDecode(json['stars']),
        image = json['image'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'image': image,
        'stars': stars,
        'author': author,
        'publisher': publisher,
        'content': content,
        'date': date,
      };
}
