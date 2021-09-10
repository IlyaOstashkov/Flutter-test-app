// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_object_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectDetail _$ArtObjectDetailFromJson(Map<String, dynamic> json) =>
    ArtObjectDetail(
      elapsedMilliseconds: json['elapsedMilliseconds'] as int,
      artObject: ArtObject.fromJson(json['artObject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtObjectDetailToJson(ArtObjectDetail instance) =>
    <String, dynamic>{
      'elapsedMilliseconds': instance.elapsedMilliseconds,
      'artObject': instance.artObject,
    };
