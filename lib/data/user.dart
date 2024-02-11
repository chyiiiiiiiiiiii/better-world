import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class PlayInfo with _$PlayInfo {
  factory PlayInfo({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'current_level') @Default(1) int currentLevel,
    @JsonKey(name: 'current_score') @Default(0) int currentScore,
    @JsonKey(name: 'total_score') @Default(0) int totalScore,
    @JsonKey(name: 'per_click_score') @Default(1) int perClickScore,
    @JsonKey(name: 'is_game_completed') @Default(false) bool isGameCompleted,
  }) = _User;

  factory PlayInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayInfoFromJson(json);
}
