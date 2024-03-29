import 'package:envawareness/constants/trash_recycle_data.dart';
import 'package:envawareness/data/recycle_game_card.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/recycle_game_state.dart';
import 'package:envawareness/utils/game_helper.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recycle_game_controller.g.dart';

@riverpod
class RecycleGameController extends _$RecycleGameController {
  @override
  RecycleGameState build() {
    const cardCount = 10;

    final shuffleData = recycleData.toList()..shuffle();
    final selectedCards = shuffleData
        .take(10)
        .map(
          RecycleGameCard.fromJson,
        )
        .toList();

    final currentLevel =
        ref.read(playControllerProvider).requireValue.playInfo.currentLevel;

    final addScore = calculateGamePerItemScore(
      currentLevel: currentLevel,
      numItems: cardCount,
      maxScoreProportionToTotalScore: 0.25,
    );

    return RecycleGameState(
      totalCount: cardCount,
      cards: selectedCards,
      addScore: addScore.toInt(),
    );
  }

  Future<void> getPrize(int score) async {
    await ref
        .read(playControllerProvider.notifier)
        .updateClickCount(needReset: true);
    await ref
        .read(playControllerProvider.notifier)
        .updateMyScore(extraScore: score);
  }

  void updateCardPosition(int position) {
    state = state.copyWith(cardPosition: position);
  }

  void updateCardIndex(int index) {
    state = state.copyWith(currentCardIndex: index);
  }

  void onSwipe({
    required AxisDirection direction,
    required RecycleGameCard card,
  }) {
    if (card.isRecyclable && direction == AxisDirection.right) {
      pass(card: card);
    } else if (!card.isRecyclable && direction == AxisDirection.left) {
      pass(card: card);
    } else {
      state = state.copyWith(
        answeredWrongCards: [
          ...state.answeredWrongCards,
          card,
        ],
      );
    }
  }

  void pass({
    required RecycleGameCard card,
  }) {
    final passCount = state.passCount + 1;
    final totalScore = state.totalScore + state.addScore;

    state = state.copyWith(
      passCount: passCount,
      answeredCorrectCards: [
        ...state.answeredCorrectCards,
        card,
      ],
      totalScore: totalScore,
    );
  }
}
