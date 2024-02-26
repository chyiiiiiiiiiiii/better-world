import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:envawareness/controllers/recycle_game_controller.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecycleGamePage extends ConsumerStatefulWidget {
  const RecycleGamePage({super.key});
  static const routePath = '/recycle-game-page';

  @override
  ConsumerState<RecycleGamePage> createState() => _RecycleGamePageState();
}

class _RecycleGamePageState extends ConsumerState<RecycleGamePage> {
  double position = 0;
  int currentCardIndex = 0;

  String scoreTitle(int score) {
    debugPrint('=======score : $score=========');
    if (score >= 10) {
      return '環保小天使';
    } else if (score >= 5) {
      return '環保高手';
    } else if (score >= 3) {
      return '環保達人';
    } else if (score >= 1) {
      return '環保新手';
    } else {
      return '環保小白';
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameCards = ref.watch(recycleGameCardsProvider);
    final gameScore = ref.watch(recycleGameScoreProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: currentCardIndex != 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.scale(
                        scale: position < 0 ? (position.abs() * 0.003 + 1) : 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '🔥',
                              style: context.textTheme.headlineMedium,
                            ),
                            Text(
                              'Not',
                              style: context.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: position > 0 ? (position * 0.003 + 1) : 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '♻️',
                              style: context.textTheme.headlineMedium,
                            ),
                            Text(
                              'Recyclable',
                              style: context.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    Visibility(
                      visible: currentCardIndex != 9,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: AppinioSwiper(
                          cardCount: gameCards.length,
                          onCardPositionChanged: (currentPosition) {
                            position = currentPosition.offset.dx;
                            setState(() {});
                          },
                          onSwipeEnd: (preIndex, targetIndex, swipe) {
                            position = 0;
                            ref
                                .read(recycleGameControllerProvider.notifier)
                                .onSwipe(
                                  direction: swipe.direction,
                                  card: gameCards[preIndex],
                                );
                            currentCardIndex = preIndex;
                            setState(() {});
                          },
                          cardBuilder: (context, index) {
                            final data = gameCards[index];

                            return Center(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          data.imageUrl,
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      data.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.value.toString(),
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
                              'Score:',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              gameScore.toString(),
                              style: context.textTheme.displayLarge,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              '你是${scoreTitle(gameScore)} ！',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            DefaultButton(
                              onPressed: () async {
                                if (mounted) {
                                  context.pop();
                                }

                                await ref
                                    .read(
                                      recycleGameControllerProvider.notifier,
                                    )
                                    .getPrize(gameScore);
                              },
                              text: 'Get Reward',
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
    );
  }
}
