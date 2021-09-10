// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'art_object_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtObjectDetail _$ArtObjectDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ArtObjectDetail',
      json,
      ($checkedConvert) {
        final val = ArtObjectDetail(
          elapsedMilliseconds:
              $checkedConvert('elapsed_milliseconds', (v) => v as int),
          artObject: $checkedConvert('art_object',
              (v) => ArtObject.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'elapsedMilliseconds': 'elapsed_milliseconds',
        'artObject': 'art_object'
      },
    );
