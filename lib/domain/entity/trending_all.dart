// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'trending_all.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrendingAll {
  final String? posterPath;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  TrendingAll(
      {required this.posterPath,
      required this.adult,
      required this.overview,
      required this.releaseDate,
      required this.genreIds,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.title,
      required this.backdropPath,
      required this.popularity,
      required this.voteCount,
      required this.video,
      required this.voteAverage});

  factory TrendingAll.fromJson(Map<String, dynamic> json) =>
      _$TrendingAllFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingAllToJson(this);

  static DateTime? parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }
}
