import 'package:json_annotation/json_annotation.dart';
part 'web_image.g.dart';

@JsonSerializable()
class WebImage {
  const WebImage({required this.url});

  final String? url;

  factory WebImage.fromJson(Map<String, dynamic> json) =>
      _$WebImageFromJson(json);
}
