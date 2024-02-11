// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelInfoImpl _$$LevelInfoImplFromJson(Map<String, dynamic> json) =>
    _$LevelInfoImpl(
      level: json['level'] as int,
      earthImageUrl: json['earth_image_url'] as String,
      passScore: json['pass_score'] as int,
    );

Map<String, dynamic> _$$LevelInfoImplToJson(_$LevelInfoImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'earth_image_url': instance.earthImageUrl,
      'pass_score': instance.passScore,
    };
