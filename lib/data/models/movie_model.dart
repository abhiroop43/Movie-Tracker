import 'dart:convert';

class MovieModel {
  final int id;
  final String overview;
  final String posterPath;
  final String title;

  MovieModel({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  MovieModel copyWith({
    int? id,
    String? overview,
    String? posterPath,
    String? title,
  }) {
    return MovieModel(
      id: id ?? this.id,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'overview': overview,
      'poster_path': posterPath,
      'title': title,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieModel(id: $id, overview: $overview, posterPath: $posterPath, title: $title)';
  }

  @override
  bool operator ==(covariant MovieModel other) {
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
