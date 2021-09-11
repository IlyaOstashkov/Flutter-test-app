// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'art_object_pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectPack _$ArtObjectPackFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ArtObjectPack',
      json,
      ($checkedConvert) {
        final val = ArtObjectPack(
          count: $checkedConvert('count', (v) => v as int),
          artObjects: $checkedConvert(
              'art_objects',
              (v) => (v as List<dynamic>)
                  .map((e) => ArtObject.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'artObjects': 'art_objects'},
    );
