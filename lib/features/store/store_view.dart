import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/extensions/int_extension.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/features/store/store_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/endangered_species_cards_page.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreView extends ConsumerWidget {
  const StoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.store,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Gaps.h84,
          Text(
            l10n.availableScore(availableScore),
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Gaps.h12,
          Row(
            children: products.indexed.map(
              (e) {
                return Expanded(
                  child: _Item(
                    index: e.$1,
                    product: e.$2,
                  ),
                );
              },
            ).toList(),
          ),
          Gaps.h12,
          const _AnimalCard(),
        ],
      ).animate().fade(
            delay: const Duration(
              milliseconds: 1000,
            ),
          ),
    );
  }
}

class _AnimalCard extends ConsumerWidget {
  const _AnimalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalCardPrice = ref.watch(
          storeControllerProvider.select(
            (value) => value.value?.animalCardPrice,
          ),
        ) ??
        0;

    if (animalCardPrice.isZero) {
      return const SizedBox.shrink();
    }

    return AppTap(
      onTap: () async {
        final data = await ref
            .read(storeControllerProvider.notifier)
            .purchaseAnimalCard();
        if (data == null) {
          return;
        }

        if (!context.mounted) {
          return;
        }

        await showSpeciesCardDialog(
          context,
          info: data,
          canNavigateSpeciesPage: true,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/animals.png',
            colorBlendMode: BlendMode.modulate,
            width: context.width / 3,
            height: context.width / 3,
          ),
          Text(
            'Gotcha\n\$$animalCardPrice',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ).animate().scale(
            delay: const Duration(
              milliseconds: 1500,
            ),
            duration: const Duration(
              milliseconds: 150,
            ),
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
    final l10n = context.l10n;

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
              .show(l10n.doNotHaveEnoughScore);

          return;
        }

        if (isProductGot) {
          ref.read(showMessageProvider.notifier).show(l10n.haveBoughtIt);

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
          Text(
            '+${product.addScore}/${product.validTimeSeconds}(s)',
            style: context.textTheme.titleMedium,
          ),
          Text(
            '\$${product.price}',
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
