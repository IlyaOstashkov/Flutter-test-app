import 'package:json_annotation/json_annotation.dart';
part 'art_object_dating.g.dart';

@JsonSerializable()
class ArtObjectDating {
  const ArtObjectDating({
    required this.presentingDate,
  });

  final String presentingDate;

  factory ArtObjectDating.fromJson(Map<String, dynamic> json) =>
      _$ArtObjectDatingFromJson(json);
}
