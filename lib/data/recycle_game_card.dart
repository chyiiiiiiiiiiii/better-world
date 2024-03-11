import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recycle_game_card.freezed.dart';
part 'recycle_game_card.g.dart';

@freezed
class RecycleGameCard with _$RecycleGameCard {
  factory RecycleGameCard({
    @Default('') String name,
    @Default('') @JsonKey(name: 'name_en') String nameEn,
    @Default('') @JsonKey(name: 'name_ja') String nameJa,
    @Default(0) @JsonKey(name: 'recyclable_value') int recyclableValue,
    @Default('') @JsonKey(name: 'image_url') String imageUrl,
  }) = _RecycleGameCard;

  factory RecycleGameCard.fromJson(Map<String, dynamic> json) =>
      _$RecycleGameCardFromJson(json);
}

extension RecycleGameCardExtension on RecycleGameCard {
  String translatedName(Locale? locale) {
    return switch (locale?.languageCode) {
      'ja' => nameJa,
      'zh' => name,
      _ => nameEn,
    };
  }

  bool get isRecyclable => recyclableValue > 0;
}
