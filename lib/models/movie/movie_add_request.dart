class MovieAddRequest {
  String? title;
  int? movieId;
  String? image;
  List<dynamic>? stars;
  String? actors;
  String? directors;
  String? prodYear;
  String? content;
  String? date;
  String? type;

  MovieAddRequest(
      {this.title,
      this.movieId,
      this.image,
      this.stars,
      this.directors,
      this.actors,
      this.prodYear,
      this.content,
      this.type,
      this.date});

  MovieAddRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        movieId = json['movieId'],
        content = json['content'],
        date = json['date'],
        actors = json['actors'],
        prodYear = json['prodYear'],
        directors = json['directors'],
        stars = json['stars'],
        type = json['type'],
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
      'date': date,
      'type': type
    };
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'image': image,
        'movieId': movieId,
        'stars': stars.toString(),
        'directors': directors,
        'prodYear': prodYear,
        'actors': actors,
        'content': content,
        'date': date,
        'type': type
      };
}
