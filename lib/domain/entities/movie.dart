class Movie {
  int? id;

  String? overview;

  String? posterPath;

  String? title;

  Movie({this.id, this.overview, this.posterPath, this.title});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    overview = json['overview'];

    posterPath = json['poster_path'];

    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;

    data['overview'] = overview;

    data['poster_path'] = posterPath;

    data['title'] = title;

    return data;
  }
}
