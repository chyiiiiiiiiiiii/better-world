import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/features/store/store_controller.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class StoreView extends ConsumerWidget {
  const StoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(
      playControllerProvider.select(
        (value) => value.requireValue.products,
      ),
    );
    final availableScore = ref.watch(
      playControllerProvider.select(
        (value) => value.requireValue.playInfo.availableScore,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(Spacings.px20),
      child: PlayAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        delay: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 500),
        builder: (context, opacity, _) {
          return Opacity(
            opacity: opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'STORE',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Gaps.h84,
                Text(
                  'Available scores: $availableScore',
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Gaps.h12,
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(Spacings.px12),
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: Spacings.px16,
                      crossAxisSpacing: Spacings.px32,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products.elementAt(index);

                      return _Item(
                        index: index,
                        product: product,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Item extends ConsumerWidget {
  const _Item({
    required this.index,
    required this.product,
  });

  final int index;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableScore = ref.watch(
      playControllerProvider.select(
        (value) => value.requireValue.playInfo.availableScore,
      ),
    );
    final validPurchaseProducts = ref.watch(
      playControllerProvider.select(
        (value) => value.requireValue.getValidPurchaseProducts(),
      ),
    );
    final hasEnoughScore = availableScore >= product.price;
    final isProductGot = validPurchaseProducts.contains(product);
    final isProductAvailable = hasEnoughScore && !isProductGot;

    return AppTap(
      onTap: () {
        if (!hasEnoughScore) {
          ref
              .read(showMessageProvider.notifier)
              .show('You do not have enough score.');

          return;
        }

        if (isProductGot) {
          ref.read(showMessageProvider.notifier).show('You have bought it.');

          return;
        }

        ref.read(storeControllerProvider.notifier).purchase(product: product);
      },
      child: Column(
        children: [
          Image.asset(
            'assets/images/product_1.png',
            color: isProductAvailable ? null : Colors.grey,
            colorBlendMode: BlendMode.modulate,
          ).animate().scale(
                delay: const Duration(
                  milliseconds: 1000,
                ),
                duration: Duration(
                  milliseconds: 150 * index,
                ),
                begin: Offset.zero,
                end: const Offset(1, 1),
              ),
          Text('\$${product.price}').animate().fade(
                delay: const Duration(
                  milliseconds: 1000,
                ),
                duration: Duration(
                  milliseconds: 150 * index,
                ),
              ),
        ],
      ),
    );
  }
}
