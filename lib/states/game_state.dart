import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@freezed
class GameState with _$GameState {
  factory GameState({
    required PlayInfo playInfo,
    required LevelInfo levelInfo,
    required int levelTotalCount,
    required double finishProgress,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}
