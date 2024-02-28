import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/can_recycle_page.dart';
import 'package:envawareness/pages/catch_game_page.dart';
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
    final l10n = context.l10n;

    final isEarthBlocked = ref.watch(isEarthBlockProvider);

    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.restore_rounded,
            color: Colors.red,
          ),
          onPressed: () async {
            // Temp for restoring data.

            final newPlayInfo =
                ref.read(playControllerProvider).requireValue.playInfo.copyWith(
                      currentLevel: 1,
                      currentScore: 0,
                      isGameCompleted: false,
                      perClickScore: 1,
                      totalScore: 0,
                      usedScore: 0,
                    );

            await ref.watch(playControllerProvider.notifier).updatePlayInfo(
                  newPlayInfo,
                );
            await ref
                .read(playControllerProvider.notifier)
                .updateLevelInfo(level: 1);
            ref.read(playControllerProvider.notifier).updateScoresPerSecond();
          },
        ),
        DefaultButton(
          onPressed: () {
            context.push(CanRecyclePage.routePath);
          },
          text: l10n.titleIdentifyHelper,
        ),
        DefaultButton(
          onPressed: () {
            context.push(CatchGamePage.routePath);
          },
          text: l10n.titleCatchGame,
        ),
        DefaultButton(
          onPressed: () {
            ref.read(playControllerProvider.notifier).onLeaderBoardTap();
          },
          text: isEarthBlocked ? l10n.close : l10n.store,
        ),
      ],
    );
  }
}
