import 'package:flutter_test_app/models/art_object_dating/art_object_dating.dart';
import 'package:flutter_test_app/models/web_image/web_image.dart';
import 'package:json_annotation/json_annotation.dart';
part 'art_object.g.dart';

/*
NOTE: To simplify code, I use only response models in the project. In a large 
project, it is better to divide models into response and business logic models. 
Accordingly, it will be necessary to map the response models into the business 
logic models. 
I used the json_annotation, json_serializable, build_runner packages to generate 
the fromJson implementations for me.
*/

@JsonSerializable()
class ArtObject {
  const ArtObject({
    required this.id,
    required this.objectNumber,
    required this.title,
    required this.webImage,
    required this.description,
    required this.principalOrFirstMaker,
    required this.dating,
  });

  final String id;
  final String objectNumber;
  final String title;
  final WebImage webImage;
  final String description;
  final String principalOrFirstMaker;
  final ArtObjectDating dating;

  factory ArtObject.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectFromJson(json);
}
