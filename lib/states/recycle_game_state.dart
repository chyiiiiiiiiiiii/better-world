import 'package:envawareness/data/recycle_game_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recycle_game_state.freezed.dart';
part 'recycle_game_state.g.dart';

@freezed
class RecycleGameState with _$RecycleGameState {
  factory RecycleGameState({
    @Default(0) int totalCount,
    @Default(0) int passCount,
    @Default(0) int totalScore,
    @Default(0) int currentCardIndex,
    @Default(0) int cardPosition,
    @Default(0) int addScore,
    @Default([]) List<RecycleGameCard> cards,
    @Default([]) List<RecycleGameCard> answeredWrongCards,
    @Default([]) List<RecycleGameCard> answeredCorrectCards,
  }) = _RecycleGameState;

  factory RecycleGameState.fromJson(Map<String, dynamic> json) =>
      _$RecycleGameStateFromJson(json);
}
