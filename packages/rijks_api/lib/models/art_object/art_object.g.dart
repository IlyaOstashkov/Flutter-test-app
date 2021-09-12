// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter, unused_element

part of 'art_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObject _$ArtObjectFromJson(Map<String, dynamic> json) => ArtObject(
      objectNumber: json['objectNumber'] as String,
      title: json['title'] as String?,
      webImage: json['webImage'] == null
          ? null
          : WebImage.fromJson(json['webImage'] as Map<String, dynamic>),
      description: json['description'] as String?,
      principalOrFirstMaker: json['principalOrFirstMaker'] as String?,
      dating: json['dating'] == null
          ? null
          : ArtObjectDating.fromJson(json['dating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtObjectToJson(ArtObject instance) => <String, dynamic>{
      'objectNumber': instance.objectNumber,
      'title': instance.title,
      'webImage': instance.webImage,
      'description': instance.description,
      'principalOrFirstMaker': instance.principalOrFirstMaker,
      'dating': instance.dating,
    };
