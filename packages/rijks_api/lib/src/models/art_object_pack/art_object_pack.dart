import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'art_object_pack.g.dart';

@JsonSerializable()
class ArtObjectPack {
  const ArtObjectPack({
    required this.count,
    required this.artObjects,
  });

  final int count;
  final List<ArtObject> artObjects;

  factory ArtObjectPack.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectPackFromJson(json);
}
