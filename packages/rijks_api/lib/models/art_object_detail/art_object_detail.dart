import 'package:json_annotation/json_annotation.dart';
import 'package:rijks_api/models/art_object/art_object.dart';
part 'art_object_detail.g.dart';

@JsonSerializable()
class ArtObjectDetail {
  const ArtObjectDetail({
    required this.elapsedMilliseconds,
    required this.artObject,
  });

  final int elapsedMilliseconds;
  final ArtObject artObject;

  factory ArtObjectDetail.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectDetailFromJson(json);
}
