class MovieCreditsResponse {
  final int id;
  final List<MovieCast> cast;
  final List<MovieCrew> crew;

  MovieCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  MovieCreditsResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cast = json['cast'] != null
            ? (json['cast'] as List).map((e) => MovieCast.fromJson(e)).toList()
            : [],
        crew = json['crew'] != null
            ? (json['crew'] as List).map((e) => MovieCrew.fromJson(e)).toList()
            : [];
}

class MovieCast {
  final bool adult;
  final int? gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String? originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  MovieCast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  MovieCast.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        gender = json['gender'],
        id = json['id'],
        knownForDepartment = json['knownForDepartment'],
        name = json['name'],
        originalName = json['originalName'],
        popularity = json['popularity'],
        profilePath = json['profilePath'],
        castId = json['castId'],
        character = json['character'],
        creditId = json['creditId'],
        order = json['order'];
}

class MovieCrew {
  final bool adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? department;
  final String? job;

  MovieCrew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.department,
    required this.job,
  });

  MovieCrew.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        gender = json['gender'],
        id = json['id'],
        knownForDepartment = json['knownForDepartment'],
        name = json['name'],
        originalName = json['originalName'],
        popularity = json['popularity'],
        profilePath = json['profilePath'],
        castId = json['castId'],
        department = json['department'],
        job = json['job'];
}
