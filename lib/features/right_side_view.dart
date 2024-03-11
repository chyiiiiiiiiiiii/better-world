import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/can_recycle_page.dart';
import 'package:envawareness/pages/catch_game_page.dart';
import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:envawareness/widgets/background_shinning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RightSideView extends ConsumerWidget {
  const RightSideView({
    required this.canPlayRecycleGame,
    super.key,
  });

  final bool canPlayRecycleGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Column(
      children: [
        BackgroundShinning(
          isShinning: canPlayRecycleGame,
          child: AppTap(
            onTap: () {
              canPlayRecycleGame
                  ? context.push(CatchGamePage.routePath)
                  : ref
                      .read(showMessageProvider.notifier)
                      .show(l10n.remindClickForPoint);
            },
            child: AnimatedSize(
              duration: Durations.medium2,
              child: Image.asset(
                'assets/images/catch.png',
                width: canPlayRecycleGame ? 48.0 : 44.0,
                height: canPlayRecycleGame ? 48.0 : 44.0,
                color: canPlayRecycleGame ? null : Colors.grey,
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ),
        Gaps.h32,
        BackgroundShinning(
          isShinning: canPlayRecycleGame,
          child: AppTap(
            onTap: () {
              canPlayRecycleGame
                  ? context.push(RecycleGamePage.routePath)
                  : ref
                      .read(showMessageProvider.notifier)
                      .show(l10n.remindClickForPoint);
            },
            child: AnimatedSize(
              duration: Durations.medium2,
              child: Image.asset(
                'assets/images/recycle-bin.png',
                width: canPlayRecycleGame ? 48.0 : 44.0,
                height: canPlayRecycleGame ? 48.0 : 44.0,
                color: canPlayRecycleGame ? null : Colors.grey,
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ),
        Gaps.h32,
        AppTap(
          onTap: () {
            context.push(CanRecyclePage.routePath);
          },
          child: Image.asset(
            'assets/images/scan.png',
            width: 48,
            height: 48,
          ),
        ),
      ],
    );
  }
}
