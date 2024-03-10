import 'package:envawareness/data/product.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ValidProductSideView extends StatelessWidget {
  const ValidProductSideView({
    required this.validPurchaseProducts,
    super.key,
  });

  final List<Product> validPurchaseProducts;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: validPurchaseProducts
          .map(
            (e) => Column(
              children: [
                Row(
                  children: [
                    e.getIcon(size: 20),
                    Gaps.w4,
                    Text(
                      '${e.translatedName(l10n)} (+${e.addScore})',
                      style:
                          context.textTheme.titleMedium?.copyWith(height: -0.1),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            reverse: true,
                          ), // loop
                        )
                        .fade(duration: Durations.extralong3),
                  ],
                ),
                Gaps.h20,
              ],
            ),
          )
          .toList(),
    );
  }
}
