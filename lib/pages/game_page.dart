import 'dart:io';

import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/features/menu/menu_widget.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  static const routePath = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(showMessageProvider, (previous, next) async {
      if (next.isEmpty) {
        return;
      }

      await showMessageDialog<void>(
        context,
        message: next,
      );

      ref.invalidate(showMessageProvider);
    });

    final isEarthBlock = ref.watch(isEarthBlockProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    return Material(
      color: context.colorScheme.background,
      child: Container(
        decoration: BoxDecoration(
          image: isDarkMode
              ? const DecorationImage(
                  opacity: 0.3,
                  image: AssetImage('assets/images/bg.gif'),
                  fit: BoxFit.cover,
                )
              : null,
          gradient: RadialGradient(
            colors: [
              const Color.fromARGB(202, 248, 205, 126),
              context.theme.scaffoldBackgroundColor,
              context.theme.scaffoldBackgroundColor,
            ],
            stops: const [0.0, 0.85, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: Platform.isAndroid ? context.paddingTop / 2 : 0,
            bottom: context.safePaddingBottom,
          ),
          child: ref.watch(playControllerProvider).when(
            data: (gameState) {
              final validPurchaseProducts =
                  gameState.getValidPurchaseProducts();

              return Stack(
                alignment: Alignment.center,
                children: [
                  const ParticleArea(),
                  const Positioned.fill(
                    top: 50,
                    child: GameZdog(),
                  ),
                  if (!isEarthBlock)
                    const PlayView()
                  else
                    const Positioned.fill(
                      top: 120,
                      child: StoreView(),
                    ),
                  const Positioned(
                    bottom: Spacings.px8,
                    child: MenuWidget(),
                  ),
                  Positioned(
                    left: Spacings.px8,
                    bottom: Spacings.px84,
                    child: ValidProductSideView(
                      validPurchaseProducts: validPurchaseProducts,
                    ),
                  ),
                  Positioned(
                    right: Spacings.px8,
                    bottom: Spacings.px84,
                    child: RightSideView(
                      canPlayRecycleGame:
                          !isEarthBlock && gameState.canPlayRecycleGame,
                    ),
                  ),
                ],
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              return Text(
                '$error',
              );
            },
          ),
        ),
      ),
    );
  }
}
