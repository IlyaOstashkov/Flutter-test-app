// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'art_object_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectDetail _$ArtObjectDetailFromJson(Map<String, dynamic> json) =>
    ArtObjectDetail(
      artObject: json['artObject'] == null
          ? null
          : ArtObject.fromJson(json['artObject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtObjectDetailToJson(ArtObjectDetail instance) =>
    <String, dynamic>{
      'artObject': instance.artObject,
    };
