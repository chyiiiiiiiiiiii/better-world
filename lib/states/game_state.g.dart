// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      playInfo: PlayInfo.fromJson(json['playInfo'] as Map<String, dynamic>),
      levelInfo: LevelInfo.fromJson(json['levelInfo'] as Map<String, dynamic>),
      levelTotalCount: json['levelTotalCount'] as int,
      finishProgress: (json['finishProgress'] as num).toDouble(),
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'playInfo': instance.playInfo.toJson(),
      'levelInfo': instance.levelInfo.toJson(),
      'levelTotalCount': instance.levelTotalCount,
      'finishProgress': instance.finishProgress,
    };
