// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recycle_game_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecycleGameCardImpl _$$RecycleGameCardImplFromJson(
        Map<String, dynamic> json) =>
    _$RecycleGameCardImpl(
      name: json['name'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      nameJa: json['name_ja'] as String? ?? '',
      recyclableValue: json['recyclable_value'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
    );

Map<String, dynamic> _$$RecycleGameCardImplToJson(
        _$RecycleGameCardImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_en': instance.nameEn,
      'name_ja': instance.nameJa,
      'recyclable_value': instance.recyclableValue,
      'image_url': instance.imageUrl,
    };
