import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class PlayView extends ConsumerWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(playControllerProvider).requireValue;
    final levelInfo = gameState.levelInfo;
    final playInfo = gameState.playInfo;

    final username = ref.watch(
      authControllerProvider.select((state) => state?.displayName ?? ''),
    );

    final isEarthBlocked = ref.watch(isEarthBlockProvider);

    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Re',
                      style: context.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      'assets/images/recycling.png',
                      height: 28,
                    ),
                  ],
                ),
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 500),
                  value: playInfo.currentScore,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 48,
                          ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${playInfo.perClickScore}/s',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                if (isEarthBlocked)
                  PlayAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, opacity, _) {
                      return Center(
                        child: Opacity(
                          opacity: opacity,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'Menu',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              const Divider(
                                color: Color.fromARGB(255, 66, 66, 66),
                                thickness: 2,
                                indent: 50,
                                endIndent: 50,
                              ),
                              const OptionWidget(label: 'Option1'),
                              const OptionWidget(
                                label: 'game',
                              ),
                              const OptionWidget(
                                label: 'game',
                              ),
                              const OptionWidget(
                                label: 'game',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // TextButton(
                //   onPressed: () {
                //     ref.read(showDashProvider.notifier).state =
                //         !ref.read(showDashProvider);
                //   },
                //   child: const Text(
                //     'showDash',
                //     style: TextStyle(
                //       fontSize: 8,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     ref
                //         .read(trashMonsterControllerProvider.notifier)
                //         .createMonster();
                //   },
                //   child: const Text(
                //     'createMonster',
                //     style: TextStyle(
                //       fontSize: 8,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    context.push(RecycleGamePage.routePath);
                  },
                  child: const Text(
                    'game',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: DefaultButton(
                    onPressed: () {
                      ref
                          .read(playControllerProvider.notifier)
                          .onLeaderBoardTap();
                    },
                    text: isEarthBlocked ? 'Close' : 'Leaderboard',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).signOut(),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        'Option1',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
