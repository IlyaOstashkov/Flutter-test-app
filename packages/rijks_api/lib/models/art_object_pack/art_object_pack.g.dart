// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter, unused_element

part of 'art_object_pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectPack _$ArtObjectPackFromJson(Map<String, dynamic> json) =>
    ArtObjectPack(
      count: json['count'] as int,
      artObjects: (json['artObjects'] as List<dynamic>)
          .map((e) => ArtObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtObjectPackToJson(ArtObjectPack instance) =>
    <String, dynamic>{
      'count': instance.count,
      'artObjects': instance.artObjects,
    };
