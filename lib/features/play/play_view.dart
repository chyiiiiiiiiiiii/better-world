import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayView extends ConsumerWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      authControllerProvider.select((state) => state),
    );
    final username = user?.displayName ?? '';
    final userPhotoURL = user?.photoURL ?? '';

    final gameState = ref.watch(playControllerProvider).requireValue;
    final levelInfo = gameState.levelInfo;
    final playInfo = gameState.playInfo;

    final validProductScore = gameState.getValidProductScore();
    final scorePerSecond = playInfo.perClickScore + validProductScore;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                AppTap(
                  onTap: () {
                    showChooseDialog(
                      context,
                      message: 'Want to sign out?',
                      onConfirm: () =>
                          ref.read(authControllerProvider.notifier).signOut(),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: userPhotoURL,
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
                ),
                Gaps.w12,
                Text(
                  'Hi, $username',
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
            Gaps.h8,
            Row(
              children: [
                Text(
                  'Level: ${levelInfo.level}',
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Pass Score: ${levelInfo.passScore}',
                    style: context.textTheme.titleMedium,
                  ),
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
      ),
    );
  }
}
