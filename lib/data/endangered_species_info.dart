import 'dart:io';

import 'package:flutter/material.dart';
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
  List<Widget> get endangerStars {
    final starIcon = Icon(Icons.star_rounded, color: Colors.yellow[800]);
    return switch (level) {
      'EX' => [starIcon, starIcon, starIcon, starIcon, starIcon, starIcon],
      'EW' => [starIcon, starIcon, starIcon, starIcon, starIcon],
      'CR' => [starIcon, starIcon, starIcon, starIcon],
      'EN' => [starIcon, starIcon, starIcon],
      'VU' => [starIcon, starIcon],
      'NT' => [starIcon],
      'LC' => [],
      _ => [],
    };
  }

  String get enDangerLevelName {
    return switch (level) {
      'EX' => 'Extinct',
      'EW' => 'Extinct in the Wild',
      'CR' => 'Critically Endangered',
      'EN' => 'Endangered',
      'VU' => 'Vulnerable',
      'NT' => 'Near Threatened',
      'LC' => 'Least Concern',
      _ => 'Data Deficient',
    };
  }

  String get translatedName {
    final languageCode = Platform.localeName.split('_').firstOrNull ?? 'en';

    return switch (languageCode) {
      'ja' => nameJa,
      'zh' => name,
      _ => nameEn,
    };
  }
}
