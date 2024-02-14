import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/repositories/game_repository.dart';
import 'package:envawareness/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuWidget extends ConsumerWidget {
  const MenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEarthBlocked = ref.watch(isEarthBlockProvider);

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.restore_rounded,
              color: Colors.red,
            ),
            onPressed: () async {
              // Temp for restoring data.

              final newPlayInfo = ref
                  .read(playControllerProvider)
                  .requireValue
                  .playInfo
                  .copyWith(
                    currentLevel: 1,
                    currentScore: 0,
                    isGameCompleted: false,
                    perClickScore: 1,
                    totalScore: 0,
                    usedScore: 0,
                  );

              await ref
                  .watch(gameRepositoryProvider)
                  .updatePlayInfo(playInfo: newPlayInfo);
              await ref
                  .read(playControllerProvider.notifier)
                  .updateLevelInfo(level: 1);
              ref.read(playControllerProvider.notifier).updateScoresPerSecond();
            },
          ),
          DefaultButton(
            onPressed: () {
              context.push(RecycleGamePage.routePath);
            },
            text: 'GAME',
          ),
          DefaultButton(
            onPressed: () {
              ref.read(playControllerProvider.notifier).onLeaderBoardTap();
            },
            text: isEarthBlocked ? 'CLOSE' : 'STORE',
          ),
        ],
      ),
    );
  }
}
