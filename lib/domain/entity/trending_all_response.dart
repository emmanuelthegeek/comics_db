// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:comics_db_app/domain/entity/trending_all.dart';

part 'trending_all_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TrendingAllResponse {
  final int page;
  @JsonKey(name: 'results')
  List<TrendingAll> trendingAll;
  final int totalResults;
  final int totalPages;

  TrendingAllResponse(
      {required this.page,
      required this.trendingAll,
      required this.totalResults,
      required this.totalPages});

  factory TrendingAllResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingAllResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingAllResponseToJson(this);
}
