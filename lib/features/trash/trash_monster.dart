import 'package:envawareness/features/trash/trash_monster_controller.dart';
import 'package:envawareness/utils/radient.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sprite/sprite.dart';
import 'package:zflutter/zflutter.dart';

class TrashMonster extends ConsumerStatefulWidget {
  const TrashMonster({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrashZdogState();
}

class _TrashZdogState extends ConsumerState<TrashMonster> {
  @override
  Widget build(BuildContext context) {
    ref.watch(trashMonsterControllerProvider);
    ref.watch(trashMonsterLifeProvider);

    final monsterNumber = ref.watch(trashMonsterNumberProvider);
    final isDissapear = !ref.watch(isShowTrashMonsterProvider);

    return IgnorePointer(
      ignoring: isDissapear,
      child: Center(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(40),
              child: Stack(
                children: [
                  if (!isDissapear)
                    Positioned.fill(
                      child: MirrorAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 10),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        builder: (context, value, _) {
                          return ZIllustration(
                            children: [
                              ZPositioned(
                                translate: ZVector(100, -150 + value, 0),
                                rotate: ZVector(
                                  10.toRadius(),
                                  0,
                                  30.0.toRadius(),
                                ),
                                child: ZShape(
                                  path: [
                                    ZMove.only(
                                      x: -32,
                                      y: -40,
                                    ), // start at top left
                                    ZLine.only(
                                      x: 32,
                                      y: -40,
                                    ), // line to top right
                                    ZLine.only(
                                      x: -10,
                                    ), // line to bottom left
                                    ZLine.only(
                                      x: 32,
                                    ), // line to bottom right
                                    ZLine.only(
                                      x: -10,
                                      y: 50,
                                    ), // line to bottom left
                                    ZLine.only(
                                      x: -5,
                                      y: 25,
                                    ), // line to bottom right
                                    ZLine.only(
                                      x: -55,
                                      y: 25,
                                    ), // line to bottom right
                                  ],
                                  stroke: 10,
                                  color:
                                      const Color.fromARGB(255, 242, 199, 60),
                                  fill: true,
                                ),
                              ),
                              ZPositioned(
                                translate: ZVector(-90, -100 + (value / 2), 0),
                                rotate: ZVector(
                                  10.toRadius(),
                                  180.toRadius(),
                                  30.0.toRadius(),
                                ),
                                scale: const ZVector.all(0.5),
                                child: ZShape(
                                  path: [
                                    ZMove.only(
                                      x: -32,
                                      y: -40,
                                    ), // start at top left
                                    ZLine.only(
                                      x: 32,
                                      y: -40,
                                    ), // line to top right
                                    ZLine.only(
                                      x: -10,
                                    ), // line to bottom left
                                    ZLine.only(
                                      x: 32,
                                    ), // line to bottom right
                                    ZLine.only(
                                      x: -10,
                                      y: 50,
                                    ), // line to bottom left
                                    ZLine.only(
                                      x: -5,
                                      y: 25,
                                    ), // line to bottom right
                                    ZLine.only(
                                      x: -55,
                                      y: 25,
                                    ), // line to bottom right
                                  ],
                                  stroke: 10,
                                  color:
                                      const Color.fromARGB(255, 242, 199, 60),
                                  fill: true,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      ref.read(isShowTrashMonsterProvider.notifier).state =
                          false;
                    },
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: FadeOutParticle(
                        disappear: isDissapear,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Sprite(
                              imagePath:
                                  'assets/images/trash_sprite/trash_$monsterNumber.png',
                              size: const Size(300, 300),
                              axis: Axis.vertical,
                              amount: 36,
                              stepTime: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
