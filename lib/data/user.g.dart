// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userId: json['user_id'] as String,
      currentLevel: json['current_level'] as int? ?? 1,
      currentScore: json['current_score'] as int? ?? 0,
      totalScore: json['total_score'] as int? ?? 0,
      perClickScore: json['per_click_score'] as int? ?? 1,
      isGameCompleted: json['is_game_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'current_level': instance.currentLevel,
      'current_score': instance.currentScore,
      'total_score': instance.totalScore,
      'per_click_score': instance.perClickScore,
      'is_game_completed': instance.isGameCompleted,
    };
