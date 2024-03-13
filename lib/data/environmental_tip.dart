import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'environmental_tip.freezed.dart';
part 'environmental_tip.g.dart';

@freezed
class EnvironmentalTip with _$EnvironmentalTip {
  factory EnvironmentalTip({
    @Default('') @JsonKey(name: 'text_en') String nameEn,
    @Default('') @JsonKey(name: 'text_ja') String nameJa,
    @Default('') @JsonKey(name: 'text_zh') String nameZh,
  }) = _EnvironmentalTip;

  factory EnvironmentalTip.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentalTipFromJson(json);
}

extension EnvironmentalTipExtension on EnvironmentalTip {
  String translatedName(Locale? locale) {
    return switch (locale?.languageCode) {
      'ja' => nameJa,
      'zh' => nameZh,
      _ => nameEn,
    };
  }
}
