// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_object_pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectPack _$ArtObjectPackFromJson(Map<String, dynamic> json) =>
    ArtObjectPack(
      elapsedMilliseconds: json['elapsedMilliseconds'] as int,
      count: json['count'] as int,
      artObjects: (json['artObjects'] as List<dynamic>)
          .map((e) => ArtObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtObjectPackToJson(ArtObjectPack instance) =>
    <String, dynamic>{
      'elapsedMilliseconds': instance.elapsedMilliseconds,
      'count': instance.count,
      'artObjects': instance.artObjects,
    };
