class MovieAddRequest {
  final String title;
  final int movieId;
  final String image;
  final List<dynamic> stars;
  final String actors;
  final String directors;
  final String prodYear;
  final String content;
  final String date;

  MovieAddRequest(
      {required this.title,
      required this.movieId,
      required this.image,
      required this.stars,
      required this.directors,
      required this.actors,
      required this.prodYear,
      required this.content,
      required this.date});

  MovieAddRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        movieId = json['movieId'],
        content = json['content'],
        date = json['date'],
        actors = json['actors'],
        prodYear = json['prodYear'],
        directors = json['directors'],
        stars = json['stars'],
        image = json['image'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'movieId': movieId,
      'image': image,
      'stars': stars,
      'directors': directors,
      'prodYear': prodYear,
      'actors': actors,
      'content': content,
      'date': date
    };
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'image': image,
        'stars': stars.toString(),
        'directors': directors,
        'prodYear': prodYear,
        'actors': actors,
        'content': content,
        'date': date,
      };
}
