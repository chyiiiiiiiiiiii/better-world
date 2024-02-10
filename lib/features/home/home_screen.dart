import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:envawareness/features/controller/dash_controller.dart';
import 'package:envawareness/features/controller/home_controller.dart';
import 'package:envawareness/features/controller/trash_monster_controller.dart';
import 'package:envawareness/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final points = ref.watch(pointControllerProvider);
    final passivePoints = ref.watch(passivePointProvider);
    final isEarthBlocked = ref.watch(isEarthBlockProvider);

    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Re',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    'assets/recycling.png',
                    height: 28,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 500),
                    value: points,
                    textStyle:
                        Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontSize: 48,
                            ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$passivePoints/s',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 14)),
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
                                "Menu",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              const Divider(
                                color: Color.fromARGB(255, 66, 66, 66),
                                thickness: 2,
                                indent: 50,
                                endIndent: 50,
                              ),
                              const OptionWidget(label: "Option1"),
                              const OptionWidget(
                                label: "game",
                              ),
                              const OptionWidget(
                                label: "game",
                              ),
                              const OptionWidget(
                                label: "game",
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(showDashProvider.notifier).state =
                        !ref.read(showDashProvider);
                  },
                  child: const Text(
                    'showDash',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(trashMonsterControllerProvider.notifier)
                        .createMonster();
                  },
                  child: const Text(
                    'createMonster',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: DefaultButton(
                    onPressed: () {
                      ref
                          .read(homeControllerProvider.notifier)
                          .leaderBoardClicked();
                    },
                    text: isEarthBlocked ? 'Close' : 'Leaderboard',
                  ),
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
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Option1",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
