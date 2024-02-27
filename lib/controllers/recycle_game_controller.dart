import 'dart:math';

import 'package:envawareness/constants/trash_recycle_data.dart';
import 'package:envawareness/data/recycle_game_card.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/recycle_game_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recycle_game_controller.g.dart';

@riverpod
class RecycleGameController extends _$RecycleGameController {
  @override
  RecycleGameState build() {
    final playLevel =
        ref.read(playControllerProvider).requireValue.playInfo.currentLevel;
    final addScore = switch (playLevel) {
      > 150 => 4000,
      > 100 => 2000,
      > 50 => 1000,
      > 20 => 500,
      > 10 => 100,
      _ => 50,
    };

    const cardCount = 10;

    final random = Random();
    final selectedCards = <RecycleGameCard>[];
    for (var i = 0; i < cardCount; i++) {
      final index = random.nextInt(recycleData.length);
      selectedCards.add(RecycleGameCard.fromJson(recycleData[index]));
    }

    return RecycleGameState(
      totalCount: cardCount,
      cards: selectedCards,
      addScore: addScore,
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
    if (card.value > 0 && direction == AxisDirection.right) {
      pass();
    } else if (card.value == 0 && direction == AxisDirection.left) {
      pass();
    }
  }

  void pass() {
    final passCount = state.passCount + 1;
    final totalScore = state.totalScore + state.addScore;

    state = state.copyWith(
      passCount: passCount,
      totalScore: totalScore,
    );
  }
}
