import 'dart:math';

import 'package:envawareness/constants/trash_recycle_data.dart';
import 'package:envawareness/data/recycle_game_card.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recycle_game_controller.g.dart';

@riverpod
class RecycleGameController extends _$RecycleGameController {
  Future<void> getPrize(int score) async {
    await ref
        .read(playControllerProvider.notifier)
        .updateClickCount(needReset: true);
    await ref
        .read(playControllerProvider.notifier)
        .updateMyScore(extraScore: score * 100);
  }

  void onSwipe({
    required AxisDirection direction,
    required RecycleGameCard card,
  }) {
    if (card.value > 0 && direction == AxisDirection.right) {
      ref.read(recycleGameScoreProvider.notifier).addScore();
    } else if (card.value == 0 && direction == AxisDirection.left) {
      ref.read(recycleGameScoreProvider.notifier).addScore();
    }
  }

  @override
  void build() {
    return;
  }
}

@riverpod
class RecycleGameCards extends _$RecycleGameCards {
  @override
  List<RecycleGameCard> build() {
    final rnd = Random();
    final selectedData = <RecycleGameCard>[];

    for (var i = 0; i < 10; i++) {
      final index = rnd.nextInt(recycleData.length);
      selectedData.add(RecycleGameCard.fromJson(recycleData[index]));
    }

    return selectedData;
  }
}

@riverpod
class RecycleGameScore extends _$RecycleGameScore {
  void addScore() {
    state += 100;
  }

  @override
  int build() {
    return 0;
  }
}
