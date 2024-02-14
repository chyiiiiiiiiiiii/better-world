import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/repositories/game_repository.dart';
import 'package:envawareness/repositories/store_repository.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

part 'play_controller.g.dart';

@riverpod
class PlayController extends _$PlayController {
  StreamSubscription<DocumentSnapshot<PlayInfo>>? _playInfoSubscription;
  Timer? _scoresPerSecondTimer;
  Timer? _checkValidPurchaseTimer;
  Timer? _uploadScoreTimer;

  String get _userId => ref.watch(authRepositoryProvider).userId;

  final int _scoreReadyToUpload = 0;

  @override
  FutureOr<GameState> build() async {
    final playInfo = await getPlayInfo();
    final levelInfo = await getLevelInfo(level: playInfo.currentLevel);
    final products = await getProducts();
    final levelTotalCount = await getLevelTotalCount();
    final finishProgress =
        (playInfo.currentScore / levelInfo.passScore).clamp(0.5, 1.0);
    final purchaseHistoryList =
        await ref.read(storeRepositoryProvider).getValidPurchaseHistory();

    listenPlayInfo();

    updateScoresPerSecond();
    checkValidPurchasePerSecond();
    _uploadScoreTimer ??=
        Timer.periodic(const Duration(seconds: 5), (timer) {});

    ref.onDispose(() {
      _playInfoSubscription?.cancel();
      _playInfoSubscription = null;

      _scoresPerSecondTimer?.cancel();
      _scoresPerSecondTimer = null;
      _checkValidPurchaseTimer?.cancel();
      _checkValidPurchaseTimer = null;
      _uploadScoreTimer?.cancel();
      _uploadScoreTimer = null;
    });

    return GameState(
      levelInfo: levelInfo,
      playInfo: playInfo,
      products: products,
      levelTotalCount: levelTotalCount,
      validPurchases: purchaseHistoryList,
      finishProgress: finishProgress,
    );
  }

  void updateScoresPerSecond() {
    _scoresPerSecondTimer ??=
        Timer.periodic(const Duration(seconds: 1), (timer) {
      final isGameCompleted = state.requireValue.playInfo.isGameCompleted;
      if (isGameCompleted) {
        _scoresPerSecondTimer?.cancel();
        _scoresPerSecondTimer = null;

        return;
      }

      updateMyScore();
    });
  }

  void checkValidPurchasePerSecond() {
    _checkValidPurchaseTimer ??=
        Timer.periodic(const Duration(seconds: 1), (timer) {
      update(
        (previous) {
          final filteredData = previous.validPurchases
              .where(
                (element) =>
                    element.endAt > DateTime.now().millisecondsSinceEpoch,
              )
              .toList();

          return previous.copyWith(
            validPurchases: filteredData,
          );
        },
      );
    });
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

  Future<LevelInfo> getLevelInfo({required int level}) async {
    final gameRepository = ref.watch(gameRepositoryProvider);

    final levelInfo = await gameRepository.getLevelInfo(level: level);
    if (levelInfo == null) {
      throw Exception("Can not obtain user's level info");
    }

    return levelInfo;
  }

  Future<List<Product>> getProducts() async {
    final gameRepository = ref.watch(gameRepositoryProvider);

    final products = await gameRepository.getProducts();
    if (products.isEmpty) {
      throw Exception('Can not get any product.');
    }

    return products;
  }

  Future<void> updateLevelInfo({required int level}) async {
    final levelInfo = await getLevelInfo(level: level);

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

  Future<void> addValidPurchase(PurchaseHistory history) async {
    await update(
      (previous) => previous.copyWith(
        validPurchases: [history, ...previous.validPurchases],
      ),
    );
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

    ref.read(showMessageProvider.notifier).show(
          'Congratulations on passing level ${playInfo.currentLevel}, keep saving the planet!',
        );

    final newPlayInfo = await updateMyLevelToNext();
    await updateLevelInfo(level: newPlayInfo.currentLevel);
  }

  Future<bool> checkIsGameCompleted() async {
    final isFinalLevel = state.requireValue.playInfo.currentLevel ==
        state.requireValue.levelTotalCount;
    final isPassScore = state.requireValue.playInfo.currentScore >=
        state.requireValue.levelInfo.passScore;
    if (!isFinalLevel || !isPassScore) {
      return false;
    }

    ref.read(showMessageProvider.notifier).show(
          'Congratulations on saving the all planets, you are truly an environmental hero!',
        );

    final playInfo = state.requireValue.playInfo;
    final newPlayInfo = playInfo.copyWith(isGameCompleted: true);

    await ref
        .watch(gameRepositoryProvider)
        .updatePlayInfo(playInfo: newPlayInfo);

    return true;
  }

  void onEarthTap() {
    final blockEarth = ref.read(isEarthBlockProvider);
    if (blockEarth) {
      return;
    }

    ref.read(confettiControllerProvider).stop();
    ref.read(confettiControllerProvider).play();

    updateMyScore();
  }

  Future<void> updateMyScore() async {
    final playInfo = state.requireValue.playInfo;
    final isGameCompleted = await checkIsGameCompleted();
    if (isGameCompleted) {
      return;
    }

    final newScore = playInfo.currentScore + playInfo.perClickScore;
    final newTotalScore = playInfo.totalScore + playInfo.perClickScore;
    final newPlayInfo = playInfo.copyWith(
      currentScore: newScore,
      totalScore: newTotalScore,
    );

    await ref
        .watch(gameRepositoryProvider)
        .updatePlayInfo(playInfo: newPlayInfo);
  }

  Future<PlayInfo> updateMyLevelToNext() async {
    final playInfo = state.requireValue.playInfo;
    final newLevel = playInfo.currentLevel + 1;
    final newPlayInfo = playInfo.copyWith(
      currentLevel: newLevel,
      currentScore: 0,
    );

    await ref
        .watch(gameRepositoryProvider)
        .updatePlayInfo(playInfo: newPlayInfo);

    return newPlayInfo;
  }

  void onLeaderBoardTap() {
    ref.read(isEarthBlockProvider.notifier).state =
        !ref.read(isEarthBlockProvider);

    ref.read(leaderBoardAnimationControllerProvider.notifier).toggle();
  }
}

final isEarthBlockProvider = StateProvider<bool>((ref) {
  return false;
});

final leaderBoardAnimationControllerProvider =
    NotifierProvider.autoDispose<ControllerNameController, Control>(
  ControllerNameController.new,
);

class ControllerNameController extends AutoDisposeNotifier<Control> {
  void toggle() {
    if (state == Control.stop) {
      state = Control.play;
    } else if (state == Control.playReverse) {
      state = Control.play;
    } else {
      state = Control.playReverse;
    }
  }

  void update(Control control) {
    state = control;
  }

  @override
  Control build() {
    return Control.stop;
  }
}

final confettiControllerProvider = Provider<ConfettiController>((ref) {
  final confettiController =
      ConfettiController(duration: const Duration(milliseconds: 20));

  return confettiController;
});
