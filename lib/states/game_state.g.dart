// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      playInfo: PlayInfo.fromJson(json['playInfo'] as Map<String, dynamic>),
      levelInfo: LevelInfo.fromJson(json['levelInfo'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      validPurchases: (json['validPurchases'] as List<dynamic>)
          .map((e) => PurchaseHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      levelTotalCount: json['levelTotalCount'] as int,
      finishProgress: (json['finishProgress'] as num).toDouble(),
      clickCount: json['clickCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'playInfo': instance.playInfo.toJson(),
      'levelInfo': instance.levelInfo.toJson(),
      'products': instance.products.map((e) => e.toJson()).toList(),
      'validPurchases': instance.validPurchases.map((e) => e.toJson()).toList(),
      'levelTotalCount': instance.levelTotalCount,
      'finishProgress': instance.finishProgress,
      'clickCount': instance.clickCount,
    };
