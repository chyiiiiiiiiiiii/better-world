import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/controllers/earth_controller.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/setting_page.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlayView extends ConsumerWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref
        .watch(
          authControllerProvider,
        )
        .value;
    final username = user?.displayName ?? '';
    final photoURL = user?.photoURL ?? '';

    final gameState = ref.watch(playControllerProvider).requireValue;
    final levelInfo = gameState.levelInfo;
    final playInfo = gameState.playInfo;

    final validProductScore = gameState.getValidProductScore();
    final scorePerSecond = playInfo.perClickScore + validProductScore;
    final currentProgress = gameState.finishProgress;

    final isDarkMode = ref.watch(darkModeProvider);
    final editMode = ref.watch(editModeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AppTap(
                        onTap: () => context.push(SettingPage.routePath),
                        child: AppAvatar(
                          imageUrl: photoURL,
                        ),
                      ),
                      Gaps.w12,
                      Text(
                        l10n.greeting(username),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // Visibility(
                    //   child: IconButton(
                    //     icon: const Icon(
                    //       Icons.restore_rounded,
                    //       color: Colors.red,
                    //     ),
                    //     onPressed: () async {
                    //       // Temp for restoring data.

                    //       final newPlayInfo = ref
                    //           .read(playControllerProvider)
                    //           .requireValue
                    //           .playInfo
                    //           .copyWith(
                    //         currentLevel: 1,
                    //         currentScore: 0,
                    //         isGameCompleted: false,
                    //         perClickScore: 1,
                    //         totalScore: 0,
                    //         usedScore: 0,
                    //         animalCardDrawCount: 0,
                    //         ownedAnimalCardIndexes: [],
                    //       );

                    //       await ref
                    //           .watch(playControllerProvider.notifier)
                    //           .updatePlayInfo(
                    //             newPlayInfo,
                    //           );
                    //       await ref
                    //           .read(playControllerProvider.notifier)
                    //           .updateLevelInfo(level: 1);
                    //       ref
                    //           .read(playControllerProvider.notifier)
                    //           .updateScoresPerSecond();
                    //     },
                    //   ),
                    // ),
                    AppTap(
                      onTap: () {
                        ref
                            .read(darkModeProvider.notifier)
                            .update((state) => !isDarkMode);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          isDarkMode
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                        ),
                      ),
                    ),
                    Gaps.w4,
                    AppTap(
                      onTap: () {
                        ref.read(editModeProvider.notifier).toggle();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.threed_rotation,
                          color: editMode ? context.theme.primaryColor : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.h8,
            Text(
              l10n.level(levelInfo.level),
              style: context.textTheme.titleMedium,
            ),
            Gaps.h8,
            LinearProgressIndicator(
              value: currentProgress,
              color: context.colorScheme.primary,
              borderRadius:
                  const BorderRadius.all(Radius.circular(Spacings.px20)),
            ),
            Gaps.h8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.score,
                  style: context.textTheme.headlineSmall,
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
              value: playInfo.totalScore,
              textStyle: context.textTheme.displayLarge,
            ),
            Text(
              l10n.scorePerSecond(scorePerSecond),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: Durations.extralong4);
  }
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundImage: imageProvider,
            radius: 18,
          ),
        ),
      ),
    );
  }
}
