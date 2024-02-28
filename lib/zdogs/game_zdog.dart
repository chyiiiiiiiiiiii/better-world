import 'package:envawareness/controllers/earth_controller.dart';
import 'package:envawareness/features/play/game_level_widgets.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:envawareness/utils/radient.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zflutter/zflutter.dart';

class GameZdog extends ConsumerStatefulWidget {
  const GameZdog({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EarthZDogState();
}

class _EarthZDogState extends ConsumerState<GameZdog> {
  Control control = Control.stop; // define variable

  final earthClickTween = MovieTween()
    ..tween(
      'zoom',
      Tween<double>(begin: 1, end: 0.88),
      duration: const Duration(milliseconds: 100),
    )
    ..tween(
      'zoom',
      Tween<double>(begin: 0.88, end: 1),
      duration: const Duration(milliseconds: 100),
      begin: const Duration(milliseconds: 100),
    );

  final earthFlipTween = MovieTween()
    ..tween(
      'zoom',
      Tween<double>(begin: 1, end: 3.5),
      duration: const Duration(milliseconds: 100),
    )
    ..tween(
      'rotate',
      Tween<double>(begin: 0, end: 3),
      duration: const Duration(milliseconds: 100),
    )
    ..tween(
      'translate',
      Tween<double>(begin: 0, end: 40),
      duration: const Duration(milliseconds: 100),
    );

  void _toggleDirection() {
    setState(() {
      // let the animation play to the opposite direction
      control = control == Control.play ? Control.playReverse : Control.play;
    });
  }

  // for change edit mode in the first time, we need to set initial value
  bool changingEditMode = false;
  double _rotationX = 0;
  double _rotationY = 0;

  @override
  void initState() {
    // 使用默认的采样频率获取陀螺仪数据流

    // 监听陀螺仪事件流
    magnetometerEventStream(samplingPeriod: SensorInterval.gameInterval)
        .listen((event) {
      _rotationX = event.x;
      _rotationY = event.y;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final leaderBoardControl =
        ref.watch(leaderBoardAnimationControllerProvider);
    final editMode = ref.watch(editModeProvider);

    ref.listen(editModeProvider, (_, editMode) {
      changingEditMode = true;
    });

    final gameState = ref.watch(playControllerProvider).requireValue;
    final levelInfo = gameState.levelInfo;

    return AppTap(
      onTap: () {
        ref.read(playControllerProvider.notifier).onEarthTap();
        _toggleDirection();
      },
      child: CustomAnimationBuilder<Movie>(
        tween: earthFlipTween,
        control: leaderBoardControl,
        duration: const Duration(milliseconds: 800),
        builder: (context, earthFlipMovie, __) {
          final rotate = ZVector.only(y: earthFlipMovie.get('rotate'));
          return CustomAnimationBuilder<Movie>(
            tween: earthClickTween,
            control: control,
            duration: const Duration(milliseconds: 150),
            builder: (context, value, __) {
              return Stack(
                children: [
                  ZDragDetector(
                    builder: (context, zDragController) {
                      if (changingEditMode) {
                        zDragController.value = ZVector.zero;
                        changingEditMode = false;
                      }

                      final dynamicRotate = (kIsWeb || kDebugMode)
                          ? zDragController.rotate
                          : ZVector.only(
                              y: (-(_rotationX - 130) * 0.7)
                                  .clamp(
                                    -30,
                                    30,
                                  )
                                  .toRadius(),
                              x: ((_rotationY + 20) * 0.7)
                                  .clamp(-30, 30)
                                  .toRadius(),
                            );

                      final rotateValue = editMode ? dynamicRotate : rotate;

                      return ZIllustration(
                        zoom: (earthFlipMovie.get('zoom') as double) + 0.3,
                        children: [
                          ZPositioned(
                            rotate: rotateValue,
                            scale: ZVector.all(value.get('zoom')),
                            translate: ZVector.only(
                              y: earthFlipMovie.get('translate'),
                            ),
                            child: EarthZdog(rotateValue: rotateValue),
                          ),
                          ZPositioned(
                            rotate: rotateValue,
                            translate: ZVector.only(
                              y: earthFlipMovie.get('translate'),
                            ),
                            child: ZGroup(
                              children: [
                                ...getLevelWidget(levelInfo.level),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class EarthZdog extends StatelessWidget {
  const EarthZdog({
    required this.rotateValue,
    super.key,
  });

  final ZVector rotateValue;

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZHemisphere(
          diameter: 120,
          stroke: 80,
          color: const Color.fromARGB(
            255,
            39,
            139,
            233,
          ),
          backfaceColor: const Color(0xffEEAA00),
        ),
        PlanteZdog(
          paths: [
            ZMove.only(
              x: 50,
              y: -10,
              z: 90,
            ),
            ZLine.only(
              x: 90,
              y: -5,
              z: 100 - 40,
            ),
            ZLine.only(
              x: 80,
              y: 50,
              z: 100 - 45,
            ),
            ZLine.only(
              x: 40,
              y: 40,
              z: 90,
            ),
          ],
        ),
        PlanteZdog(
          paths: [
            ZMove.only(
              x: -50,
              y: -70,
              z: 10,
            ),
            ZLine.only(
              x: -90,
              y: -20,
              z: 10,
            ),
            ZLine.only(
              x: -40,
              z: 100 - 30,
            ),
            ZLine.only(
              x: -10,
              y: -20,
              z: 100,
            ),
          ],
        ),
        PlanteZdog(
          paths: [
            ZMove.only(
              x: -50,
              y: 50,
              z: 10,
            ),
            ZLine.only(
              x: -60,
              y: 60,
              z: 10,
            ),
            ZLine.only(
              x: -40,
              y: 80,
              z: 20,
            ),
          ],
        ),
        CloudZdog(
          rotate: rotateValue,
        ),
      ],
    );
  }
}

class PyramidZdog extends StatelessWidget {
  const PyramidZdog({
    super.key,
    this.rotate = const ZVector.all(0),
    this.translate = const ZVector.all(0),
    this.size = 14,
  });

  final ZVector translate;
  final ZVector rotate;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: translate,
      rotate: rotate,
      child: ZGroup(
        children: [
          ZShape(
            path: [
              ZMove.only(),
              ZLine.only(x: size, y: size, z: size),
              ZLine.only(x: -size, y: size, z: size),
            ],
            // closed by default
            stroke: 8,
            fill: true,
            color: const Color(0xffFFD700),
          ),
          ZPositioned(
            rotate: ZVector.only(y: 180.toRadius()),
            child: ZShape(
              path: [
                ZMove.only(),
                ZLine.only(x: size, y: size, z: size),
                ZLine.only(x: -size, y: size, z: size),
              ],
              // closed by default
              stroke: 8,
              fill: true,
              color: const Color(0xffE1A95F),
            ),
          ),
          ZPositioned(
            rotate: ZVector.only(y: 90.toRadius()),
            child: ZShape(
              path: [
                ZMove.only(),
                ZLine.only(x: size, y: size, z: size),
                ZLine.only(x: -size, y: size, z: size),
              ],
              // closed by default
              stroke: 8,
              fill: true,
              color: const Color(0xffC2B280),
            ),
          ),
          ZPositioned(
            rotate: ZVector.only(y: -90.toRadius()),
            child: ZShape(
              path: [
                ZMove.only(),
                ZLine.only(x: size, y: size, z: size),
                ZLine.only(x: -size, y: size, z: size),
              ],
              // closed by default
              stroke: 8,
              fill: true,
              color: const Color.fromARGB(255, 225, 182, 95),
            ),
          ),
        ],
      ),
    );
  }
}

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
            (value) => value.requireValue.getValidPurchaseProducts(),
          ),
        )
        .map((e) => e.id);
    final solarPower = validPurchaseProducts.contains('2');

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
                color: const Color.fromARGB(255, 255, 226, 154),
              ),
              ZEllipse(
                width: 100,
                height: 100,
                stroke: value + (solarPower ? 30 : 0),
                fill: true,
                color: const Color.fromARGB(255, 255, 214, 110),
              ),
              ZShape(
                stroke: 80,
                color: const Color.fromARGB(255, 249, 183, 18),
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

class CloudZdog extends StatelessWidget {
  const CloudZdog({
    required this.rotate,
    super.key,
  });
  final ZVector rotate;

  @override
  Widget build(BuildContext context) {
    return MirrorAnimationBuilder<double>(
      tween: Tween(begin: -10, end: 10),
      duration: const Duration(seconds: 15),
      curve: Curves.easeInOut,
      builder: (context, value, __) {
        return ZPositioned(
          rotate: rotate,
          child: ZGroup(
            children: [
              ZPositioned(
                translate: ZVector.only(y: value, z: -130),
                child: ZGroup(
                  children: const [
                    CloudPieceZdog(
                      offset: Offset(85, 55),
                      width: 30,
                      stroke: 25,
                    ),
                    CloudPieceZdog(
                      offset: Offset(98, 45),
                      width: 5,
                      stroke: 25,
                    ),
                  ],
                ),
              ),
              ZPositioned(
                translate: ZVector.only(y: -value),
                child: ZGroup(
                  children: const [
                    CloudPieceZdog(
                      offset: Offset(-100, -20),
                      width: 30,
                    ),
                    CloudPieceZdog(
                      offset: Offset(-85, -30),
                      width: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SolarPanel extends ConsumerWidget {
  const SolarPanel({
    this.translate = ZVector.zero,
    this.rotate = ZVector.zero,
    this.width = 40,
    this.height = 24,
    super.key,
  });
  final ZVector rotate;
  final ZVector translate;

  final double width;
  final double height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ZPositioned(
      rotate: rotate,
      translate: translate,
      child: ZGroup(
        children: [
          ZRect(
            width: width,
            height: height,
            stroke: 2.5,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          // 腳架
          ZShape(
            color: Colors.white,
            stroke: 2.5,
            path: [
              ZMove.only(
                x: -width / 2,
                y: -height / 2,
              ),
              ZLine.only(
                x: -width / 2,
                z: -15,
                y: -height / 2,
              ),
              ZMove.only(
                x: -width / 2,
                y: height / 2,
              ),
              ZLine.only(
                x: -width / 2,
                z: -10,
                y: height / 2,
              ),
              ZMove.only(
                x: width / 2,
                y: height / 2,
              ),
              ZLine.only(
                x: width / 2,
                z: -10,
                y: height / 2,
              ),
              ZMove.only(
                x: width / 2,
                y: -height / 2,
              ),
              ZLine.only(
                x: width / 2,
                z: -15,
                y: -height / 2,
              ),
            ],
          ),
          // 匡線
          ZShape(
            path: [
              ZMove.only(
                x: -width / 2 + width / 3,
                y: -height / 2,
              ),
              ZLine.only(
                x: -width / 2 + width / 3,
                y: -height / 2 + height,
              ),
              ZMove.only(
                x: -width / 2 + (width / 3) * 2,
                y: -height / 2,
              ),
              ZLine.only(
                x: -width / 2 + (width / 3) * 2,
                y: -height / 2 + height,
              ),
              ZMove.only(
                x: -width / 2,
              ),
              ZLine.only(
                x: -width / 2 + width - 1,
              ),
            ],
            closed: false,
            stroke: 2,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          ZPositioned(
            translate: const ZVector.only(z: -2),
            child: ZRect(
              width: width,
              height: height,
              stroke: 3,
              fill: true,
              color: const Color.fromARGB(255, 40, 51, 74),
            ),
          ),
        ],
      ),
    );
  }
}

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

class TriangleTreeZdog extends StatelessWidget {
  const TriangleTreeZdog({
    required this.translate,
    this.rotate = ZVector.zero,
    super.key,
  });
  final ZVector rotate;
  final ZVector translate;
  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: rotate,
      translate: translate,
      child: ZGroup(
        children: [
          ZCone(
            diameter: 30,
            length: 20,
            color: const Color.fromARGB(255, 73, 165, 87),
            backfaceColor: const Color.fromARGB(255, 73, 165, 87),
          ),
          ZPositioned(
            translate: const ZVector.only(z: 7),
            child: ZCone(
              diameter: 25,
              length: 15,
              color: const Color.fromARGB(255, 84, 183, 99),
              backfaceColor: const Color.fromARGB(255, 84, 183, 99),
            ),
          ),
          ZPositioned(
            translate: const ZVector.only(z: 14),
            child: ZCone(
              diameter: 18,
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
  }
}

class CircleTreeZdog extends StatelessWidget {
  const CircleTreeZdog({
    required this.rotate,
    required this.translate,
    super.key,
  });
  final ZVector rotate;
  final ZVector translate;
  final Color leafColor = const Color.fromARGB(255, 160, 215, 64);
  @override
  Widget build(BuildContext context) {
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
              stroke: 20,
              color: leafColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CloudPieceZdog extends StatelessWidget {
  const CloudPieceZdog({
    super.key,
    this.offset = Offset.zero,
    this.width = 10,
    this.zIndex = 100,
    this.stroke = 30,
  });
  final Offset offset;
  final double width;
  final double zIndex;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      path: [
        ZMove.only(x: offset.dx, y: offset.dy, z: zIndex),
        ZLine.only(x: offset.dx + width, y: offset.dy, z: zIndex),
      ],
      stroke: stroke,
      color: Colors.white,
    );
  }
}

class PlanteZdog extends StatelessWidget {
  const PlanteZdog({
    required this.paths,
    this.color = const Color.fromARGB(255, 120, 204, 97),
    super.key,
  });

  final List<ZPathCommand> paths;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      path: paths,
      fill: true,
      stroke: 20,
      color: color,
    );
  }
}
