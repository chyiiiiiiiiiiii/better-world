import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:zflutter/zflutter.dart';

class SunZdog extends ConsumerWidget {
  const SunZdog({
    this.translate = ZVector.zero,
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
    final solarPower = validPurchaseProducts.contains('sunny');
    final isDarkMode = ref.watch(darkModeProvider);

    return MirrorAnimationBuilder<double>(
      tween: Tween(begin: 0, end: solarPower ? 40 : 5),
      duration: Duration(seconds: solarPower ? 1 : 5),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return ZPositioned(
          rotate: rotate,
          translate: translate,
          child: ZGroup(
            children: [
              ZEllipse(
                width: 120,
                height: 120,
                stroke: value + (solarPower ? 60 : 0),
                fill: true,
                color: isDarkMode
                    ? const Color.fromARGB(255, 144, 144, 144)
                    : const Color.fromARGB(255, 255, 226, 154),
              ),
              ZEllipse(
                width: 100,
                height: 100,
                stroke: value + (solarPower ? 30 : 0),
                fill: true,
                color: isDarkMode
                    ? const Color.fromARGB(255, 197, 197, 197)
                    : const Color.fromARGB(229, 255, 214, 110),
              ),
              ZShape(
                stroke: 80,
                color: isDarkMode
                    ? const Color.fromARGB(255, 246, 244, 241)
                    : const Color.fromARGB(227, 249, 183, 18),
              ),
              ZShape(
                color: Colors.black,
                stroke: 3,
                path: [
                  ZMove.only(x: -10, y: -5, z: 10),
                  ZLine.only(x: -10, y: 5, z: 10),
                ],
              ),
              ZShape(
                color: Colors.black,
                stroke: 3,
                path: [
                  ZMove.only(
                    x: 10,
                    y: -5,
                    z: 10,
                  ),
                  ZLine.only(
                    x: 10,
                    y: 5,
                    z: 10,
                  ),
                ],
              ),
              ZShape(
                path: [
                  const ZMove.vector(
                    ZVector.only(
                      x: -10,
                      y: 15,
                      z: 10,
                    ),
                  ), // Start point
                  ZArc(
                    // First arc to form the smile
                    corner: const ZVector.only(
                      y: 25,
                      z: 10,
                    ), // Middle point to curve
                    end: const ZVector.only(
                      x: 10,
                      y: 15,
                      z: 10,
                    ), // End point
                  ),
                ],
                stroke: 3.5,
                color: Colors.black,
                closed: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
