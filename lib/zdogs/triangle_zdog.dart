import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:zflutter/zflutter.dart';

class TriangleTreeZdog extends ConsumerWidget {
  const TriangleTreeZdog({
    required this.translate,
    this.rotate = ZVector.zero,
    super.key,
  });
  final ZVector rotate;
  final ZVector translate;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validPurchaseProducts = ref
            .watch(
              playControllerProvider.select(
                (value) => value.value?.getValidPurchaseProducts(),
              ),
            )
            ?.map((e) => e.id) ??
        [];
    final treePower = validPurchaseProducts.contains('1');
    return MirrorAnimationBuilder<double>(
      tween: Tween(begin: 1, end: treePower ? 1.3 : 1.05),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return ZPositioned(
          rotate: rotate,
          translate: translate,
          child: ZGroup(
            children: [
              ZCone(
                diameter: 30 * value,
                length: 20,
                color: const Color.fromARGB(255, 73, 165, 87),
                backfaceColor: const Color.fromARGB(255, 73, 165, 87),
              ),
              ZPositioned(
                translate: ZVector.only(z: 7 * value),
                child: ZCone(
                  diameter: 25 * value,
                  length: 15,
                  color: const Color.fromARGB(255, 84, 183, 99),
                  backfaceColor: const Color.fromARGB(255, 84, 183, 99),
                ),
              ),
              ZPositioned(
                translate: ZVector.only(z: 14 * value),
                child: ZCone(
                  diameter: 18 * value,
                  length: 10,
                  color: const Color.fromARGB(255, 87, 193, 103),
                  backfaceColor: const Color.fromARGB(255, 87, 193, 103),
                ),
              ),
              ZCylinder(
                diameter: 8,
                length: 20,
                frontface: Colors.red,
                color: const Color.fromARGB(255, 161, 119, 56),
                backface: Colors.green,
              ),
            ],
          ),
        );
      },
    );
  }
}
