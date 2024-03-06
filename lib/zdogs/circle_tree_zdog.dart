import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:zflutter/zflutter.dart';

class CircleTreeZdog extends ConsumerWidget {
  const CircleTreeZdog({
    required this.rotate,
    required this.translate,
    super.key,
  });
  final ZVector rotate;
  final ZVector translate;
  final Color leafColor = const Color.fromARGB(255, 160, 215, 64);
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
      tween: Tween(begin: 1, end: treePower ? 1.2 : 1.05),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
      builder: (context, value, _) {
        return ZPositioned(
          rotate: rotate,
          translate: translate,
          child: ZGroup(
            children: [
              ZPositioned(
                translate: const ZVector.only(y: -1),
                child: ZCylinder(
                  diameter: 5,
                  length: 20,
                  color: const Color.fromARGB(255, 161, 119, 56),
                  backface: leafColor,
                ),
              ),
              ZPositioned(
                translate: const ZVector.only(
                  z: 10,
                ),
                child: ZShape(
                  stroke: 20 * value,
                  color: leafColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
