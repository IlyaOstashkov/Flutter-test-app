import 'package:flutter_test_app/models/art_object/art_object.dart';
import 'package:json_annotation/json_annotation.dart';
part 'art_object_pack.g.dart';

@JsonSerializable()
class ArtObjectPack {
  const ArtObjectPack({
    required this.elapsedMilliseconds,
    required this.count,
    required this.artObjects,
  });

  final int elapsedMilliseconds;
  final int count;
  final List<ArtObject> artObjects;

  factory ArtObjectPack.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectPackFromJson(json);
}
