import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/radient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';
import 'package:zflutter/zflutter.dart';

class WindTurbinesZdog extends ConsumerWidget {
  const WindTurbinesZdog({
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
            (value) => value.requireValue.getValidPurchaseProducts(),
          ),
        )
        .map((e) => e.id);
    final windPower = validPurchaseProducts.contains('3');
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 360),
      duration: Duration(milliseconds: (windPower ? 500 : 5000)),
      builder: (context, value, __) {
        return ZPositioned(
          rotate: rotate,
          translate: translate,
          child: ZGroup(
            children: [
              ZPositioned(
                translate: const ZVector.only(z: 15),
                rotate: ZVector.only(y: value.toRadius()),
                child: ZGroup(
                  children: [
                    ZShape(
                      closed: false,
                      stroke: 4,
                      color: Colors.white,
                      path: [
                        ZMove.only(),
                        ZLine.only(
                          z: -9,
                          x: -12,
                        ),
                      ],
                    ),
                    ZShape(
                      closed: false,
                      stroke: 4,
                      color: Colors.white,
                      path: [
                        ZMove.only(),
                        ZLine.only(
                          z: -9,
                          x: 12,
                        ),
                      ],
                    ),
                    ZShape(
                      closed: false,
                      stroke: 4,
                      color: Colors.white,
                      path: [
                        ZMove.only(),
                        ZLine.only(
                          z: 15,
                        ),
                      ],
                    ),
                    ZShape(
                      stroke: 6,
                      path: [
                        ZMove.only(y: 2),
                      ],
                      color: const Color.fromARGB(255, 255, 236, 175),
                    ),
                  ],
                ),
              ),
              ZCylinder(
                diameter: 3,
                length: 20,
                frontface: Colors.white,
                color: const Color.fromARGB(255, 242, 242, 242),
                backface: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}
