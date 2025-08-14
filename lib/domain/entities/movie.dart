import 'dart:convert';

class Movie {
  int? id;
  String? overview;
  String? posterPath;
  String? title;
  Movie({this.id, this.overview, this.posterPath, this.title});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'overview': overview,
      'posterPath': posterPath,
      'title': title,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] != null ? map['id'] as int : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      posterPath: map['posterPath'] != null
          ? map['posterPath'] as String
          : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Movie(id: $id, overview: $overview, posterPath: $posterPath, title: $title)';
  }

  Movie copyWith({
    int? id,
    String? overview,
    String? posterPath,
    String? title,
  }) {
    return Movie(
      id: id ?? this.id,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
    );
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        title.hashCode;
  }
}
