import 'dart:math' as math;
import 'dart:ui';

import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/features/play/play_view.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class LeaderBoardPage extends ConsumerWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final players = ref.watch(
      playControllerProvider.select(
        (value) => value.requireValue.leaderBoardPlayers,
      ),
    );
    final myUid = ref.watch(authControllerProvider).value?.uid ?? '';

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacings.px20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.leaderBoard,
              style: context.textTheme.headlineMedium,
            ),
            Gaps.h20,
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.px20,
                ),
                physics: const ClampingScrollPhysics(),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final isFirst = index == 0;
                  final player = players.elementAt(index);
                  final isMe = player.userId == myUid;

                  const textColor = Colors.black;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacings.px12,
                      vertical: Spacings.px8,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? context.colorScheme.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: isMe
                          ? Border.all(color: Colors.white, width: 4)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            AppAvatar(
                              imageUrl: player.userPhotoUrl,
                            ),
                            if (isFirst)
                              Positioned(
                                top: -24,
                                left: -24,
                                child: Transform.rotate(
                                  angle: 315 * math.pi / 180,
                                  child: Lottie.asset(
                                    'assets/animations/crown.lottie.json',
                                    width: 50,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Gaps.w12,
                        Expanded(
                          child: Text(
                            player.username,
                            style: context.textTheme.titleLarge
                                ?.copyWith(color: textColor),
                          ),
                        ),
                        Gaps.w8,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: player.ownedAnimalCardIndexes.length
                                    .toString(),
                                style: context.textTheme.titleLarge?.copyWith(
                                  color: textColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' 🦕',
                                    style: context.textTheme.titleSmall
                                        ?.copyWith(color: textColor),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${player.totalScore}(p)',
                              style: context.textTheme.titleSmall
                                  ?.copyWith(color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Gaps.h12;
                },
              ),
            ),
            Center(
              child: DefaultButton(
                onPressed: context.pop,
                text: l10n.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
