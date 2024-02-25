import 'package:freezed_annotation/freezed_annotation.dart';

part 'endangered_species_info.freezed.dart';
part 'endangered_species_info.g.dart';

@freezed
class EndangeredSpeciesInfo with _$EndangeredSpeciesInfo {
  factory EndangeredSpeciesInfo({
    required String name,
    required String image,
    required String level,
    @Default('') String description,
  }) = _EndangeredSpeciesInfo;

  factory EndangeredSpeciesInfo.fromJson(Map<String, dynamic> json) =>
      _$EndangeredSpeciesInfoFromJson(json);
}
