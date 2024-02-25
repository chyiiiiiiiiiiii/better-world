import 'package:envawareness/data/product.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: validPurchaseProducts
          .map(
            (e) => Column(
              children: [
                Text(
                  e.name,
                  style: context.textTheme.titleMedium,
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(
                        reverse: true,
                      ), // loop
                    )
                    .fade(duration: Durations.extralong3),
                Gaps.h8,
              ],
            ),
          )
          .toList(),
    );
  }
}
