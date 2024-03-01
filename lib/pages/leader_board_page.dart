import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/utils/build_context_extension.dart';
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
    final players =
        ref.watch(playControllerProvider).requireValue.leaderBoardPlayers;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacings.px20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacings.px12,
                      vertical: Spacings.px8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            CachedNetworkImage(
                              imageUrl: player.userPhotoUrl,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.face),
                              ),
                            ),
                            if (isFirst)
                              Positioned(
                                top: -16,
                                left: -16,
                                child: Transform.rotate(
                                  angle: 315 * math.pi / 180,
                                  child: Lottie.asset(
                                    'assets/animations/crown.lottie.json',
                                    width: 36,
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
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        Gaps.w8,
                        Text.rich(
                          TextSpan(
                            text: player.totalScore.toString(),
                            style: context.textTheme.titleLarge?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                            children: [
                              TextSpan(
                                text: ' (s)',
                                style: context.textTheme.titleSmall
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          style: context.textTheme.titleLarge
                              ?.copyWith(color: Colors.black),
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
            IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.green,
                weight: 10,
              ),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
