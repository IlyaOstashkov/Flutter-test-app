// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObject _$ArtObjectFromJson(Map<String, dynamic> json) => ArtObject(
      id: json['id'] as String,
      objectNumber: json['objectNumber'] as String,
      title: json['title'] as String,
      webImage: WebImage.fromJson(json['webImage'] as Map<String, dynamic>),
      description: json['description'] as String,
      principalOrFirstMaker: json['principalOrFirstMaker'] as String,
      dating: ArtObjectDating.fromJson(json['dating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtObjectToJson(ArtObject instance) => <String, dynamic>{
      'id': instance.id,
      'objectNumber': instance.objectNumber,
      'title': instance.title,
      'webImage': instance.webImage,
      'description': instance.description,
      'principalOrFirstMaker': instance.principalOrFirstMaker,
      'dating': instance.dating,
    };
