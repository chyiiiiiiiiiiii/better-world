import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayView extends ConsumerWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(
      authControllerProvider.select((state) => state?.displayName ?? ''),
    );

    final gameState = ref.watch(playControllerProvider).requireValue;
    final levelInfo = gameState.levelInfo;
    final playInfo = gameState.playInfo;

    final validProductScore = gameState.getValidProductScore();
    final scorePerSecond = playInfo.perClickScore + validProductScore;

    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Hi, $username',
                style: context.textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Level: ${levelInfo.level}',
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Pass Score: ${levelInfo.passScore}',
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
          Gaps.h8,
          const Divider(),
          Gaps.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Re',
                style: context.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Gaps.w8,
              Image.asset(
                'assets/images/recycling.png',
                height: 28,
              ),
            ],
          ),
          AnimatedFlipCounter(
            duration: const Duration(milliseconds: 500),
            value: playInfo.currentScore ?? 0,
            textStyle: context.textTheme.displayLarge,
          ),
          Text(
            '$scorePerSecond/s',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 14),
          ),
        ],
      ).animate().fade(),
    );
  }
}
