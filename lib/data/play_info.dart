import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_info.freezed.dart';
part 'play_info.g.dart';

@freezed
class PlayInfo with _$PlayInfo {
  factory PlayInfo({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'current_level') @Default(1) int currentLevel,
    @JsonKey(name: 'current_score') @Default(0) int currentScore,
    @JsonKey(name: 'total_score') @Default(0) int totalScore,
    @JsonKey(name: 'used_score') @Default(0) int usedScore,
    @JsonKey(name: 'per_click_score') @Default(1) int perClickScore,
    @JsonKey(name: 'is_game_completed') @Default(false) bool isGameCompleted,
  }) = _PlayInfo;

  factory PlayInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayInfoFromJson(json);
}

extension PlayInfoExtension on PlayInfo {
  int get availableScore => totalScore - usedScore;
}
