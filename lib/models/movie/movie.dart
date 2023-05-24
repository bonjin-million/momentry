class Movie {
  final String title; // 영화명
  final String prodYear; // 제작년도
  final String detailUrl; // 링크URL

  Movie({
    required this.title,
    required this.prodYear,
    required this.detailUrl,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        prodYear = json['prodYear'],
        detailUrl = json['kmdbUrl'];
}