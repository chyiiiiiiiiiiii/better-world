import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/utils/radient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zflutter/zflutter.dart';

class EarthZdog extends ConsumerStatefulWidget {
  const EarthZdog({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EarthZDogState();
}

class _EarthZDogState extends ConsumerState<EarthZdog> {
  Control control = Control.stop; // define variable

  final earthClicktween = MovieTween()
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

  final leaderTween = MovieTween()
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

  @override
  Widget build(BuildContext context) {
    final leaderBoardControl =
        ref.watch(leaderBoardAnimationControllerProvider);

    return GestureDetector(
      onTap: () {
        ref.read(playControllerProvider.notifier).onEarthTap();
        _toggleDirection();
      },
      child: CustomAnimationBuilder<Movie>(
        tween: leaderTween,
        control: leaderBoardControl,
        duration: const Duration(milliseconds: 800),
        builder: (context, leaderMovie, __) {
          final rotate = ZVector.only(y: leaderMovie.get('rotate'));
          return MirrorAnimationBuilder(
            tween: Tween(begin: 0.1, end: 20),
            duration: const Duration(seconds: 5),
            builder: (context, cloudValue, __) {
              return CustomAnimationBuilder<Movie>(
                tween: earthClicktween,
                control: control,
                duration: const Duration(milliseconds: 150),
                builder: (context, value, __) {
                  return Stack(
                    children: [
                      Transform.scale(
                        scale: value.get('zoom'),
                        child: ZIllustration(
                          zoom: leaderMovie.get('zoom'),
                          children: [
                            if (leaderMovie.get<double>('translate') < 1)
                              const ZPositioned(
                                translate: ZVector.only(z: 105),
                                child: TriangleTreeZdog(
                                  degree: 90,
                                ),
                              ),
                            if (leaderMovie.get<double>('translate') < 1)
                              const ZPositioned(
                                translate: ZVector.only(z: 105, x: 20),
                                child: CircleTreeZdog(
                                  degree: 80,
                                ),
                              ),
                            ZPositioned(
                              rotate: rotate,
                              translate: ZVector.only(
                                y: leaderMovie.get('translate'),
                              ),
                              child: ZHemisphere(
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
                            ),
                            ZPositioned(
                              rotate: rotate,
                              child: ZGroup(
                                children: [
                                  ZGroup(
                                    children: [
                                      PlanteZdog(
                                        paths: [
                                          ZMove.only(
                                            x: 50,
                                            y: -10,
                                            z: 100,
                                          ),
                                          ZLine.only(
                                            x: 90,
                                            y: -5,
                                            z: 100 - 40,
                                          ),
                                          ZLine.only(
                                            x: 80,
                                            y: 40,
                                            z: 100 - 40,
                                          ),
                                          ZLine.only(
                                            x: 80,
                                            y: 50,
                                            z: 100 - 30,
                                          ),
                                          ZLine.only(
                                            x: 40,
                                            y: 40,
                                            z: 100,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ZGroup(
                                    children: [
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
                                    ],
                                  ),
                                  ZGroup(
                                    children: [
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
                                            z: 100,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: value.get('zoom'),
                        child: ZIllustration(
                          zoom: leaderMovie.get('zoom'),
                          children: const [],
                        ),
                      ),
                      ZIllustration(
                        zoom: leaderMovie.get('zoom'),
                        children: [
                          ZPositioned(
                            rotate: rotate,
                            child: ZGroup(
                              children: [
                                ZPositioned(
                                  translate: ZVector.only(
                                    y: cloudValue.toDouble(),
                                  ),
                                  child: ZGroup(
                                    children: const [
                                      CloudZdog(
                                        offset: Offset(65, 40),
                                        width: 30,
                                      ),
                                      CloudZdog(
                                        offset: Offset(78, 30),
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                ZPositioned(
                                  translate: ZVector.only(
                                    y: -cloudValue.toDouble() / 2,
                                  ),
                                  child: ZGroup(
                                    children: const [
                                      CloudZdog(
                                        offset: Offset(-100, -20),
                                        width: 30,
                                      ),
                                      CloudZdog(
                                        offset: Offset(-85, -30),
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class TriangleTreeZdog extends StatelessWidget {
  const TriangleTreeZdog({required this.degree, super.key});
  final double degree;
  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: ZVector.only(
        x: degree.toRadius(),
      ),
      child: ZGroup(
        children: [
          ZCone(
            diameter: 30,
            length: 20,
            color: const Color.fromARGB(255, 73, 165, 87),
            backfaceColor: const Color(0xffEEAA00),
          ),
          ZPositioned(
            translate: const ZVector.only(z: 7),
            child: ZCone(
              diameter: 25,
              length: 15,
              color: const Color.fromARGB(255, 84, 183, 99),
              backfaceColor: const Color(0xffEEAA00),
            ),
          ),
          ZPositioned(
            translate: const ZVector.only(z: 14),
            child: ZCone(
              diameter: 18,
              length: 10,
              color: const Color.fromARGB(255, 87, 193, 103),
              backfaceColor: const Color(0xffEEAA00),
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
  const CircleTreeZdog({required this.degree, super.key});
  final double degree;
  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: ZVector.only(
        x: 90.toRadius(),
      ),
      child: ZGroup(
        children: [
          ZCylinder(
            diameter: 5,
            length: 20,
            color: const Color.fromARGB(255, 161, 119, 56),
            backface: Colors.green,
          ),
          ZPositioned(
            translate: const ZVector.only(z: 7),
            child: ZShape(
              stroke: 20,
              color: const Color.fromARGB(255, 84, 183, 99),
            ),
          ),
        ],
      ),
    );
  }
}

class CloudZdog extends StatelessWidget {
  const CloudZdog({
    super.key,
    this.offset = Offset.zero,
    this.width = 10,
    this.zIndex = 100,
  });
  final Offset offset;
  final double width;
  final double zIndex;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      path: [
        ZMove.only(x: offset.dx, y: offset.dy, z: zIndex),
        ZLine.only(x: offset.dx + width, y: offset.dy, z: zIndex),
      ],
      stroke: 30,
      color: Colors.white,
    );
  }
}

class PlanteZdog extends StatelessWidget {
  const PlanteZdog({
    required this.paths,
    super.key,
  });

  final List<ZPathCommand> paths;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      path: paths,
      fill: true,
      stroke: 20,
      color: const Color.fromARGB(255, 87, 193, 103),
    );
  }
}
