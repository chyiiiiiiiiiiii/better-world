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
      nameJp: json['name_jp'] as String? ?? '',
      value: json['value'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
    );

Map<String, dynamic> _$$RecycleGameCardImplToJson(
        _$RecycleGameCardImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_en': instance.nameEn,
      'name_jp': instance.nameJp,
      'value': instance.value,
      'image_url': instance.imageUrl,
    };
