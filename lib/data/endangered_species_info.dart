import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'endangered_species_info.freezed.dart';
part 'endangered_species_info.g.dart';

@freezed
class EndangeredSpeciesInfo with _$EndangeredSpeciesInfo {
  factory EndangeredSpeciesInfo({
    required String name,
    required String image,
    required String level,
    @JsonKey(name: 'name_en') required String nameEn,
    @JsonKey(name: 'name_ja') required String nameJa,
    @Default('') String description,
  }) = _EndangeredSpeciesInfo;

  factory EndangeredSpeciesInfo.fromJson(Map<String, dynamic> json) =>
      _$EndangeredSpeciesInfoFromJson(json);
}

extension EndangeredSpeciesInfoExtension on EndangeredSpeciesInfo {
  String get translatedName {
    final languageCode = Platform.localeName.split('_').firstOrNull ?? 'en';
    
    return switch (languageCode) {
      'ja' => nameJa,
      'zh' => name,
      _ => nameEn,
    };
  }
}
