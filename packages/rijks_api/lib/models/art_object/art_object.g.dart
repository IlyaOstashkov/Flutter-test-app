// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'art_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObject _$ArtObjectFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ArtObject',
      json,
      ($checkedConvert) {
        final val = ArtObject(
          objectNumber: $checkedConvert('object_number', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String?),
          webImage: $checkedConvert(
              'web_image',
              (v) => v == null
                  ? null
                  : WebImage.fromJson(v as Map<String, dynamic>)),
          description: $checkedConvert('description', (v) => v as String?),
          principalOrFirstMaker:
              $checkedConvert('principal_or_first_maker', (v) => v as String?),
          dating: $checkedConvert(
              'dating',
              (v) => v == null
                  ? null
                  : ArtObjectDating.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'objectNumber': 'object_number',
        'webImage': 'web_image',
        'principalOrFirstMaker': 'principal_or_first_maker'
      },
    );
