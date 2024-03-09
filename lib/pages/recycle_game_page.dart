import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/controllers/recycle_game_controller.dart';
import 'package:envawareness/data/recycle_game_card.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/recycle_icon.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecycleGamePage extends ConsumerWidget {
  const RecycleGamePage({super.key});
  static const routePath = '/recycle-game-page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isDarkMode = ref.watch(darkModeProvider);

    final state = ref.watch(recycleGameControllerProvider);
    final gameCards = state.cards;
    final passCount = state.passCount;
    final totalScore = state.totalScore;
    final currentCardIndex = state.currentCardIndex;
    final cardPosition = state.cardPosition;
    final answeredCorrectCards = state.answeredCorrectCards;
    final answeredWrongCards = state.answeredWrongCards;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacings.px20),
            child: Column(
              children: [
                Visibility(
                  visible: currentCardIndex != 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.scale(
                        scale: cardPosition < 0
                            ? (cardPosition.abs() * 0.003 + 1)
                            : 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/wrong.png',
                              width: context.width / 8,
                              height: context.width / 8,
                            ),
                            Text(
                              l10n.notRecyclable,
                              style: context.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale:
                            cardPosition > 0 ? (cardPosition * 0.003 + 1) : 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RecycleIcon(
                              size: context.width / 9,
                            ),
                            Text(
                              l10n.isRecyclable,
                              style: context.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: currentCardIndex != 9,
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: AppinioSwiper(
                            cardCount: gameCards.length,
                            onCardPositionChanged: (currentPosition) => ref
                                .read(recycleGameControllerProvider.notifier)
                                .updateCardPosition(
                                  currentPosition.offset.dx.toInt(),
                                ),
                            onSwipeEnd: (preIndex, targetIndex, swipe) {
                              ref
                                  .read(recycleGameControllerProvider.notifier)
                                  .onSwipe(
                                    direction: swipe.direction,
                                    card: gameCards[preIndex],
                                  );
                              ref
                                  .read(recycleGameControllerProvider.notifier)
                                  .updateCardPosition(0);
                              ref
                                  .read(recycleGameControllerProvider.notifier)
                                  .updateCardIndex(preIndex);
                            },
                            cardBuilder: (context, index) {
                              final data = gameCards[index];

                              return Center(
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.background,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Image.asset(
                                                data.imageUrl,
                                                fit: BoxFit.cover,
                                                cacheHeight: constraints
                                                    .maxHeight
                                                    .toInt(),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        data.translatedName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: currentCardIndex == 9,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                '${l10n.environmentalScore}:',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const RecycleIcon(
                                    size: 36,
                                  ),
                                  Gaps.w8,
                                  Text(
                                    totalScore.toString(),
                                    style: context.textTheme.displayLarge,
                                  ),
                                ],
                              ),
                              Gaps.h12,
                              Text.rich(
                                TextSpan(
                                  text: l10n.recyclableGameYouAre,
                                  style: context.textTheme.headlineSmall,
                                  children: [
                                    TextSpan(
                                      text: switch (passCount) {
                                        >= 10 => l10n.recyclableGameWinnerName5,
                                        >= 5 => l10n.recyclableGameWinnerName4,
                                        >= 3 => l10n.recyclableGameWinnerName3,
                                        >= 1 => l10n.recyclableGameWinnerName2,
                                        _ => l10n.recyclableGameWinnerName1,
                                      },
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(
                                        color: context.colorScheme.secondary,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' 💪🏼',
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.h20,
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(Spacings.px20),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          const gapSpacing = Spacings.px12;
                                          final perItemWidth =
                                              (constraints.maxWidth -
                                                      gapSpacing * 3) /
                                                  4;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                '答對物品',
                                                style: context
                                                    .textTheme.titleMedium,
                                              ),
                                              Divider(
                                                color: Colors.grey.shade300,
                                                thickness: 0.5,
                                              ),
                                              Gaps.h12,
                                              Wrap(
                                                spacing: Spacings.px12,
                                                runSpacing: Spacings.px12,
                                                children: answeredCorrectCards
                                                    .map(
                                                      (card) => SizedBox(
                                                        width: perItemWidth,
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    Spacings
                                                                        .px12,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    card.imageUrl,
                                                                    width:
                                                                        perItemWidth,
                                                                    height:
                                                                        perItemWidth,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                if (card
                                                                    .isRecyclable)
                                                                  Positioned(
                                                                    top: -Spacings
                                                                        .px4,
                                                                    right:
                                                                        -Spacings
                                                                            .px4,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/recycling.png',
                                                                      width: 16,
                                                                      height:
                                                                          16,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                            Text(
                                                              card.translatedName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: context
                                                                  .textTheme
                                                                  .titleSmall,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                              Gaps.h20,
                                              Text(
                                                '答錯物品',
                                                style: context
                                                    .textTheme.titleMedium,
                                              ),
                                              Divider(
                                                color: Colors.grey.shade300,
                                                thickness: 0.5,
                                              ),
                                              Gaps.h12,
                                              Wrap(
                                                spacing: Spacings.px12,
                                                runSpacing: Spacings.px12,
                                                children: answeredWrongCards
                                                    .map(
                                                      (card) => SizedBox(
                                                        width: perItemWidth,
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    Spacings
                                                                        .px12,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    card.imageUrl,
                                                                    width:
                                                                        perItemWidth,
                                                                    height:
                                                                        perItemWidth,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                if (card
                                                                    .isRecyclable)
                                                                  Positioned(
                                                                    top: -Spacings
                                                                        .px4,
                                                                    right:
                                                                        -Spacings
                                                                            .px4,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/recycling.png',
                                                                      width: 16,
                                                                      height:
                                                                          16,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                            Text(
                                                              card.translatedName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: context
                                                                  .textTheme
                                                                  .titleSmall,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.h20,
                              DefaultButton(
                                onPressed: () async {
                                  if (context.mounted) {
                                    context.pop();
                                  }

                                  await ref
                                      .read(
                                        recycleGameControllerProvider.notifier,
                                      )
                                      .getPrize(totalScore);
                                },
                                text: l10n.recyclableGameGetReward,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
