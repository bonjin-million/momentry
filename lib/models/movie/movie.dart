class Movie {
  final String title; // 영화명
  final String prodYear; // 제작년도
  final String detailUrl; // 링크URL
  final List<MoviePoster> posters;
  final List<MovieStill> stills;
  final List<MovieActor> actors;
  final List<MovieDirector> directors;

  Movie({
    required this.title,
    required this.prodYear,
    required this.detailUrl,
    required this.posters,
    required this.stills,
    required this.actors,
    required this.directors,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        prodYear = json['prodYear'],
        detailUrl = json['kmdbUrl'],
        posters = json['posters']
            .toString()
            .split("|")
            .map((e) => MoviePoster(imageUrl: e))
            .toList(),
        stills = json['stills']
            .toString()
            .split("|")
            .map((e) => MovieStill(imageUrl: e))
            .toList(),
        actors = (json['actors']["actor"] as List)
            .map((e) => MovieActor.fromJson(e))
            .toList(),
        directors = (json['directors']["director"] as List)
            .map((e) => MovieDirector.fromJson(e))
            .toList();
}

class MoviePoster {
  final String imageUrl;

  MoviePoster({required this.imageUrl});

  MoviePoster.fromJson(Map<String, dynamic> json) : imageUrl = json['imageUrl'];
}

class MovieStill {
  final String imageUrl;

  MovieStill({required this.imageUrl});

  MovieStill.fromJson(Map<String, dynamic> json) : imageUrl = json['imageUrl'];
}

class MovieDirector {
  final String directorNm;
  final String directorEnNm;
  final String directorId;

  MovieDirector({
    required this.directorNm,
    required this.directorEnNm,
    required this.directorId,
  });

  factory MovieDirector.fromJson(Map<String, dynamic> json) => MovieDirector(
      directorNm: json['directorNm'],
      directorEnNm: json['directorEnNm'],
      directorId: json['directorId']);

  Map<String, dynamic> toJson() {
    return {
      'directorNm': directorNm,
      'directorEnNm': directorEnNm,
      'directorId': directorId,
    };
  }
}

class MovieActor {
  final String actorNm;
  final String actorEnNm;
  final String actorId;

  MovieActor({
    required this.actorNm,
    required this.actorEnNm,
    required this.actorId,
  });

  factory MovieActor.fromJson(Map<String, dynamic> json) => MovieActor(
      actorNm: json['actorNm'],
      actorEnNm: json['actorEnNm'],
      actorId: json['actorId']);

  Map<String, dynamic> toJson() {
    return {
      'actorNm': actorNm,
      'actorEnNm': actorEnNm,
      'actorId': actorId,
    };
  }
}
