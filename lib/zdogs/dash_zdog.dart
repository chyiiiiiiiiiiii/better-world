import 'package:envawareness/features/controller/dash_controller.dart';
import 'package:envawareness/utils/radient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:zflutter/zflutter.dart';

class DashZdog extends ConsumerStatefulWidget {
  const DashZdog({
    Key? key,
    this.rotate = const ZVector.only(y: 0),
    this.translate = const ZVector.all(0),
    this.scale = 1,
    this.speed = 5,
  }) : super(key: key);
  final ZVector rotate;
  final ZVector translate;
  final double scale;
  final double speed;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashZdogState();
}

class _DashZdogState extends ConsumerState<DashZdog>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  AnimationController? dashController;
  late MovieTween flyTween;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    double flyHeight = 5;
    double zRotate = -30.0.toRadians();
    flyTween = MovieTween()
      ..tween(
        'x',
        Tween<double>(begin: -230.0, end: 230),
        duration: const Duration(seconds: 10),
      )
      ..tween(
        'y',
        Tween<double>(begin: -flyHeight, end: flyHeight)
            .chain(CurveTween(curve: Curves.easeInOut)),
        duration: const Duration(milliseconds: 500),
      )
      ..tween(
        'y',
        Tween<double>(begin: flyHeight, end: -flyHeight)
            .chain(CurveTween(curve: Curves.easeInOut)),
        duration: const Duration(milliseconds: 500),
        begin: const Duration(milliseconds: 500),
      )
      ..tween(
        'y',
        Tween<double>(begin: -flyHeight, end: flyHeight)
            .chain(CurveTween(curve: Curves.easeInOut)),
        duration: const Duration(milliseconds: 500),
        begin: const Duration(milliseconds: 1000),
      )
      ..tween(
        'y',
        Tween<double>(begin: flyHeight, end: -flyHeight)
            .chain(CurveTween(curve: Curves.easeInOut)),
        duration: const Duration(milliseconds: 500),
        begin: const Duration(milliseconds: 1500),
      )
      ..tween(
        'z',
        Tween<double>(begin: zRotate, end: -3.0.toRadians())
            .chain(CurveTween(curve: Curves.easeInOut)),
        duration: const Duration(milliseconds: 300),
        begin: const Duration(milliseconds: 4000),
      )
      ..tween(
        'z',
        Tween<double>(begin: -3.0.toRadians(), end: zRotate)
            .chain(CurveTween(curve: Curves.easeInOut)),
        duration: const Duration(milliseconds: 500),
        begin: const Duration(milliseconds: 4700),
      );
    update();
  }

  update() {
    Future.delayed(const Duration(seconds: 0), () {
      if (mounted) {
        animationController.forward(from: 0).whenComplete(() => update());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final showDash = ref.watch(showDashProvider);
    if (!showDash) {
      return const SizedBox();
    }
    List<Animation> dashAnimations = List.generate(
        20,
        (index) => Tween<double>(
              begin: 0,
              end: index.isEven ? widget.speed : -widget.speed,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  index * 0.05,
                  (index + 1) * 0.05,
                  curve: Curves.ease,
                ),
              ),
            ));
    return CustomAnimationBuilder(
        tween: flyTween,
        duration: const Duration(seconds: 10),
        curve: Curves.easeInOut,
        control: Control.loop,
        builder: (context, value, _) {
          return AnimatedBuilder(
              animation: animationController,
              builder: (context, _) {
                final dash = dashAnimations.fold<double>(0,
                    (previousValue, element) => previousValue + element.value);
                return ZDragDetector(builder: (context, controller) {
                  return ZIllustration(
                    zoom: 1,
                    children: [
                      ZPositioned(
                        rotate: widget.rotate.copyWith(
                          y: widget.rotate.y + value.get('z'),
                        ),
                        // rotate: controller.rotate,
                        translate: widget.translate.copyWith(
                          y: widget.translate.y + value.get('y'),
                          x: widget.translate.x + value.get('x'),
                        ),
                        scale: ZVector.all(widget.scale),
                        child: Dash(flight: dash),
                      )
                    ],
                  );
                });
              });
        });
  }
}

const Color darkBlue = Color(0xff5CC0EF);

const Color bodyColor = Color(0xffa0e6fe);

const Color brown = Color(0xff967C40);

const Color green = Color(0xff71d3c7);

const Color black = Color(0xff000000);

class Dash extends StatelessWidget {
  final double flight;

  const Dash({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: ZVector.only(y: flight),
      child: ZGroup(
        children: [
          ZShape(
            stroke: 40,
            fill: true,
            color: bodyColor,
          ),
          ZPositioned(translate: const ZVector.only(y: -20), child: hair()),
          ZPositioned(
            translate: const ZVector.only(x: 0, y: 12, z: -17),
            child: ZShape(
              stroke: 2,
              fill: true,
              path: [
                const ZMove.vector(
                  ZVector.only(x: 0, y: 0, z: 0),
                ),
                ZArc.list([
                  const ZVector.only(x: 5, y: -10, z: -8),
                  const ZVector.only(x: 8, y: -15, z: -10),
                ], null),
                ZArc.list([
                  const ZVector.only(x: 0, y: -25, z: -12),
                  const ZVector.only(x: -8, y: -15, z: -10),
                ], null),
                ZArc.list([
                  const ZVector.only(x: -5, y: -10, z: -8),
                  const ZVector.only(x: 0, y: -0, z: 0),
                ], null)
              ],
              color: darkBlue,
            ),
          ),
          ZPositioned(
            translate: const ZVector.only(x: -23, z: -2),
            rotate:
                ZVector.only(y: tau / 4 - tau / 40 - flight / 12, x: -tau / 12),
            child: wing(),
          ),
          ZPositioned(
            translate: const ZVector.only(x: 23, z: -2),
            rotate:
                ZVector.only(y: tau / 4 + tau / 40 + flight / 12, x: -tau / 12),
            child: wing(),
          ),
          ZGroup(
            sortMode: SortMode.stack,
            children: [
              ZPositioned(
                translate: const ZVector.only(x: 0, y: 0, z: 2),
                child: ZShape(
                  stroke: 2,
                  fill: true,
                  path: [
                    const ZMove.vector(
                      ZVector.only(x: 0, y: 0, z: 20),
                    ),
                    ZArc.list([
                      const ZVector.only(x: -30, y: 7, z: 15),
                      const ZVector.only(x: 0, y: 15, z: 15),
                    ], null),
                    ZArc.list([
                      const ZVector.only(x: 30, y: 7, z: 15),
                      const ZVector.only(x: 0, y: 0, z: 20),
                    ], null)
                  ],
                  color: Colors.white,
                ),
              ),
              ZPositioned(
                translate: const ZVector.only(z: 20),
                child: ZGroup(sortMode: SortMode.update, children: [
                  eye(translate: const ZVector.only(x: -7)),
                  eye(translate: const ZVector.only(x: 7)),
                  ZPositioned(
                      rotate: const ZVector.only(x: -tau / 20),
                      translate: const ZVector.only(y: 7),
                      child: ZCone(
                        color: brown,
                        length: 10,
                        stroke: 2,
                        diameter: 3,
                      )),
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Todo: Migrate to widget system and use StatelessWidgets instead of functions
ZGroup hair() => ZGroup(
      children: [
        ZPositioned(
          translate: const ZVector.only(y: -1, z: 0),
          child: ZEllipse(
            height: 6,
            width: 3,
            stroke: 4,
            color: bodyColor,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: 1, x: -2),
          rotate: const ZVector.only(z: -tau / 8),
          child: ZEllipse(
            height: 6,
            width: 3,
            stroke: 4,
            color: bodyColor,
          ),
        ),
        ZPositioned(
          translate: const ZVector.only(y: 1, x: 2),
          rotate: const ZVector.only(z: tau / 8),
          child: ZEllipse(
            height: 6,
            width: 3,
            stroke: 4,
            color: bodyColor,
          ),
        ),
      ],
    );

ZGroup eye({ZVector translate = ZVector.zero}) {
  return ZGroup(sortMode: SortMode.stack, children: [
    ZPositioned(
      translate: translate,
      child: ZCircle(
        stroke: 2,
        fill: true,
        diameter: 15,
        color: darkBlue,
      ),
    ),
    ZPositioned(
      translate: translate,
      scale: const ZVector.all(1.2),
      child: ZEllipse(
        stroke: 2,
        fill: true,
        width: 6,
        height: 8,
        color: green,
      ),
    ),
    ZPositioned(
      translate: translate + const ZVector.only(x: 0, y: 0, z: 0.1),
      child: ZEllipse(
        stroke: 2,
        fill: true,
        width: 6,
        height: 8,
        color: black,
      ),
    ),
    ZPositioned(
      translate: translate + const ZVector.only(x: 2, y: -2, z: 1),
      child: ZCircle(
        stroke: 1,
        fill: true,
        diameter: 1,
        color: Colors.white,
      ),
    )
  ]);
}

ZGroup wing() => ZGroup(
      children: [
        ZPositioned(
            scale: const ZVector.all(1.2),
            child: ZEllipse(
              stroke: 4,
              fill: true,
              width: 20,
              height: 15,
              color: darkBlue,
            )),
      ],
    );
