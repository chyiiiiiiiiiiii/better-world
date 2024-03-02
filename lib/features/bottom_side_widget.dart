import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/can_recycle_page.dart';
import 'package:envawareness/pages/leader_board_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomSideWidget extends ConsumerWidget {
  const BottomSideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final isStoreOpened = ref.watch(isStoreOpenedProvider);

    if (isStoreOpened) {
      return Center(
        child: DefaultButton(
          onPressed: ref.read(playControllerProvider.notifier).onStoreTap,
          text: l10n.close,
        ),
      )
          .animate(
            key: const Key('close'),
            delay: Durations.extralong4,
          )
          .fade();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTap(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierColor: Colors.transparent,
              builder: (
                BuildContext context,
              ) {
                return const LeaderBoardPage();
              },
            );
          },
          child: Image.asset(
            'assets/images/leaderboard.png',
            width: context.width / 7,
            height: context.width / 7,
          ),
        ),
        Gaps.w20,
        // IconButton(
        //   icon: const Icon(
        //     Icons.restore_rounded,
        //     color: Colors.red,
        //   ),
        //   onPressed: () async {
        //     // Temp for restoring data.

        //     final newPlayInfo =
        //         ref.read(playControllerProvider).requireValue.playInfo.copyWith(
        //               currentLevel: 1,
        //               currentScore: 0,
        //               isGameCompleted: false,
        //               perClickScore: 1,
        //               totalScore: 0,
        //               usedScore: 0,
        //               animalCardDrawCount: 0,
        //             );

        //     await ref.watch(playControllerProvider.notifier).updatePlayInfo(
        //           newPlayInfo,
        //         );
        //     await ref
        //         .read(playControllerProvider.notifier)
        //         .updateLevelInfo(level: 1);
        //     ref.read(playControllerProvider.notifier).updateScoresPerSecond();
        //   },
        // ),
        AppTap(
          onTap: () {
            ref.read(playControllerProvider.notifier).onStoreTap();
          },
          child: Image.asset(
            'assets/images/shop.png',
            width: context.width / 7,
            height: context.width / 7,
          ),
        ),
        Gaps.w20,
        AppTap(
          onTap: () {
            context.push(CanRecyclePage.routePath);
          },
          child: Image.asset(
            'assets/images/scan.png',
            width: context.width / 7,
            height: context.width / 7,
          ),
        ),
      ],
    )
        .animate(
          key: const Key('open'),
          delay: Durations.extralong4,
        )
        .fadeIn();
  }
}
