import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/user.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/repositories/game_repository.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  StreamSubscription<DocumentSnapshot<PlayInfo>>? _playInfoSubscription;

  String get _userId => ref.watch(authRepositoryProvider).userId;

  @override
  FutureOr<GameState> build() async {
    final playInfo = await getPlayInfo();
    final levelInfo = await getLevelInfo(playInfo: playInfo);
    final levelTotalCount = await getLevelTotalCount();
    final finishProgress =
        (playInfo.currentScore / levelInfo.passScore).clamp(0.5, 1.0);

    listenPlayInfo();

    ref.onDispose(() {
      _playInfoSubscription?.cancel();
      _playInfoSubscription = null;
    });

    return GameState(
      levelInfo: levelInfo,
      playInfo: playInfo,
      levelTotalCount: levelTotalCount,
      finishProgress: finishProgress,
    );
  }

  Future<PlayInfo> getPlayInfo() async {
    final gameRepository = ref.watch(gameRepositoryProvider);

    try {
      final playInfo = await gameRepository.getPlayInfo(userId: _userId);
      if (playInfo == null) {
        throw Exception("Can not obtain user's play-game history");
      }

      return playInfo;
    } catch (error) {
      final playInfo = await gameRepository.addPlayInfo(userId: _userId);

      return playInfo;
    }
  }

  Future<LevelInfo> getLevelInfo({required PlayInfo playInfo}) async {
    final gameRepository = ref.watch(gameRepositoryProvider);

    final levelInfo =
        await gameRepository.getLevelInfo(level: playInfo.currentLevel);
    if (levelInfo == null) {
      throw Exception("Can not obtain user's level info");
    }

    return levelInfo;
  }

  Future<void> updateLevelInfo({required PlayInfo user}) async {
    final levelInfo = await getLevelInfo(playInfo: user);

    await update((previous) => previous.copyWith(levelInfo: levelInfo));
  }

  Future<int> getLevelTotalCount() async {
    final gameRepository = ref.watch(gameRepositoryProvider);

    final count = await gameRepository.getLevelTotalCount();

    return count;
  }

  void listenPlayInfo() {
    final stream =
        ref.watch(gameRepositoryProvider).listenUser(userId: _userId);
    _playInfoSubscription = stream.listen((snapshot) {
      final playInfo = snapshot.data();
      if (playInfo == null) {
        return;
      }

      onListenPlayInfo(playInfo);
    });
  }

  Future<void> onListenPlayInfo(PlayInfo playInfo) async {
    final finishProgress =
        (playInfo.currentScore / state.requireValue.levelInfo.passScore)
            .clamp(0.5, 1.0);
    await update(
      (previous) => previous.copyWith(
        playInfo: playInfo,
        finishProgress: finishProgress,
      ),
    );

    await checkIsPassLevel(playInfo: playInfo);
  }

  Future<void> checkIsPassLevel({required PlayInfo playInfo}) async {
    final isPassLevel =
        playInfo.currentScore >= state.requireValue.levelInfo.passScore;
    if (!isPassLevel) {
      return;
    }

    final isGameCompleted = await checkIsGameCompleted();
    if (isGameCompleted) {
      return;
    }

    ref
        .read(showMessageProvider.notifier)
        .show('恭喜你通過第 ${playInfo.currentLevel} 關，繼續拯救星球吧！');

    final newPlayInfo = await updateMyLevelToNext();
    await updateLevelInfo(user: newPlayInfo);
  }

  Future<bool> checkIsGameCompleted() async {
    final isFinalLevel = state.requireValue.playInfo.currentLevel ==
        state.requireValue.levelTotalCount;
    final isPassScore = state.requireValue.playInfo.currentScore >=
        state.requireValue.levelInfo.passScore;
    if (!isFinalLevel || !isPassScore) {
      return false;
    }

    ref.read(showMessageProvider.notifier).show('恭喜你拯救了所有星球，你真的是個環保英雄！');

    final playInfo = state.requireValue.playInfo;
    final newPlayInfo = playInfo.copyWith(isGameCompleted: true);

    await ref.watch(gameRepositoryProvider).updateUser(playInfo: newPlayInfo);

    return true;
  }

  Future<void> updateMyScore() async {
    final playInfo = state.requireValue.playInfo;
    final isGameCompleted = await checkIsGameCompleted();
    if (isGameCompleted) {
      return;
    }

    final newScore = playInfo.currentScore + playInfo.perClickScore;
    final newPlayInfo = playInfo.copyWith(currentScore: newScore);

    await ref.watch(gameRepositoryProvider).updateUser(playInfo: newPlayInfo);
  }

  Future<PlayInfo> updateMyLevelToNext() async {
    final playInfo = state.requireValue.playInfo;
    final newLevel = playInfo.currentLevel + 1;
    final newPlayInfo = playInfo.copyWith(
      currentLevel: newLevel,
      currentScore: 0,
    );

    await ref.watch(gameRepositoryProvider).updateUser(playInfo: newPlayInfo);

    return newPlayInfo;
  }
}
