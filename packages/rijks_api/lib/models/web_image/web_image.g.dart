// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'web_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebImage _$WebImageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'WebImage',
      json,
      ($checkedConvert) {
        final val = WebImage(
          guid: $checkedConvert('guid', (v) => v as String),
          url: $checkedConvert('url', (v) => v as String),
        );
        return val;
      },
    );
