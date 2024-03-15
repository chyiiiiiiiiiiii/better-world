import 'package:envawareness/constants/environmental_tip_data.dart';
import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/data/environmental_tip.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/features/bottom_side_widget.dart';
import 'package:envawareness/features/particle/particle.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/features/play/play_view.dart';
import 'package:envawareness/features/right_side_view.dart';
import 'package:envawareness/features/store/store_view.dart';
import 'package:envawareness/features/valid_product_side_view.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/zdogs/game_zdog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  static const routePath = '/';

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Durations.extralong4,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(showMessageProvider, (previous, next) async {
        if (next.isEmpty) {
          return;
        }

        await showMessageDialog<void>(
          context,
          message: next,
        );

        ref.invalidate(showMessageProvider);
      })
      ..listen(showLevelUpMessageProvider, (previous, next) async {
        if (next.isEmpty) {
          return;
        }

        final appLocale = ref.watch(appLocaleProvider).value;

        final shuffleData = environmentTipData.toList()..shuffle();
        final environmentTip = shuffleData
            .map(
              EnvironmentalTip.fromJson,
            )
            .toList()
            .first;
        final tipText = environmentTip.translatedName(appLocale);

        await showLevelUpDialog<void>(
          context,
          message: next[0],
          nextLevel: next[1],
          tipText: tipText,
        );

        ref.invalidate(showLevelUpMessageProvider);
      });

    final isDarkMode = ref.watch(darkModeProvider);

    return Material(
      color: context.colorScheme.background,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: isDarkMode
                    ? const DecorationImage(
                        opacity: 0.3,
                        image: AssetImage('assets/images/bg.gif'),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              final animatedValue = animationController.value;

              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color.fromARGB(156, 248, 205, 126),
                      const Color.fromARGB(66, 255, 193, 78),
                      if (isDarkMode)
                        Colors.transparent
                      else
                        const Color.fromARGB(0, 255, 255, 255),
                    ],
                    stops: [
                      0.4 + (0.1 * animatedValue),
                      0.7 - (0.1 * animatedValue),
                      1.0,
                    ],
                  ),
                ),
                child: child,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: Platform.isAndroid ? context.paddingTop / 2 : 0,
                bottom: context.safePaddingBottom,
              ),
              child: ref.watch(playControllerProvider).when(
                data: (gameState) {
                  final isStoreOpened = ref.watch(isStoreOpenedProvider);
                  final validPurchaseProducts =
                      gameState.getValidPurchaseProducts();
                  const durationMilliseconds = 1400;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      const ParticleArea(),
                      Positioned.fill(
                        top: 50,
                        child: const GameZdog(
                          key: ValueKey('Zdog'),
                        )
                            .animate()
                            .scale(
                              begin: const Offset(.2, .2),
                              end: const Offset(1, 1),
                              duration: const Duration(
                                milliseconds: durationMilliseconds,
                              ),
                            )
                            .move(
                              begin: Offset(0, context.height),
                              end: Offset.zero,
                              duration: const Duration(
                                milliseconds: durationMilliseconds,
                              ),
                              curve: Curves.easeInOutBack,
                            ),
                      ),
                      if (!isStoreOpened)
                        const PlayView()
                      else
                        const Positioned.fill(
                          child: StoreView(),
                        ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: Spacings.px8,
                        child: BottomSideWidget(),
                      ),
                      Positioned(
                        left: Spacings.px8,
                        bottom: context.height / 7,
                        child: ValidProductSideView(
                          validPurchaseProducts: validPurchaseProducts,
                        ),
                      ),
                      Positioned(
                        right: Spacings.px8,
                        bottom: Spacings.px100,
                        child: isStoreOpened
                            ? const SizedBox.shrink()
                            : const RightSideView()
                                .animate(
                                  delay: Durations.extralong4,
                                )
                                .fade(),
                      ),
                    ],
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return const SizedBox.shrink();

                  // return Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(Spacings.px20),
                  //     child: Text(
                  //       l10n.gameStartupError,
                  //       textAlign: TextAlign.center,
                  //       style: context.textTheme.titleMedium,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
