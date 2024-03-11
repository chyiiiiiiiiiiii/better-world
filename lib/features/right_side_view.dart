import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:envawareness/widgets/background_shinning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RightSideView extends ConsumerWidget {
  const RightSideView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(playControllerProvider);
    final canPlayRecycleGame =
        gameState.valueOrNull?.canPlayRecycleGame ?? false;
    final progress = (gameState.valueOrNull?.clickCount ?? 0) / 20;

    return AppTap(
      onTap: () {
        if (!canPlayRecycleGame) return;
        showGamesDialog<String>(context);
      },
      child: BackgroundShinning(
        isShinning: canPlayRecycleGame,
        child: Column(
          children: [
            if (canPlayRecycleGame)
              Image.asset(
                'assets/images/game_icon/plant.png',
                width: 48,
              )
            else
              ColorFiltered(
                colorFilter: const ColorFilter.matrix(<double>[
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: Image.asset(
                  'assets/images/game_icon/plant.png',
                  width: 48,
                ),
              ),
            Gaps.h12,
            SizedBox(
              width: 48,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
