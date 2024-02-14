import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_info.freezed.dart';
part 'level_info.g.dart';

@freezed
class LevelInfo with _$LevelInfo {
  factory LevelInfo({
    @JsonKey(name: 'level') required int level,
    @JsonKey(name: 'pass_score') required int passScore,
  }) = _LevelInfo;

  factory LevelInfo.fromJson(Map<String, dynamic> json) =>
      _$LevelInfoFromJson(json);
}
