import 'package:json_annotation/json_annotation.dart';
import 'package:rijks_api/models/art_object_dating/art_object_dating.dart';
import 'package:rijks_api/models/web_image/web_image.dart';
part 'art_object.g.dart';

@JsonSerializable()
class ArtObject {
  const ArtObject({
    required this.objectNumber,
    required this.title,
    required this.webImage,
    required this.description,
    required this.principalOrFirstMaker,
    required this.dating,
  });

  final String objectNumber;
  final String? title;
  final WebImage? webImage;
  final String? description;
  final String? principalOrFirstMaker;
  final ArtObjectDating? dating;

  factory ArtObject.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectFromJson(json);
}
