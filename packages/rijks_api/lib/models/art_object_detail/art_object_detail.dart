import 'package:json_annotation/json_annotation.dart';
import 'package:rijks_api/models/art_object/art_object.dart';
part 'art_object_detail.g.dart';

@JsonSerializable()
class ArtObjectDetail {
  const ArtObjectDetail({
    required this.artObject,
  });

  final ArtObject? artObject;

  factory ArtObjectDetail.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectDetailFromJson(json);
}
