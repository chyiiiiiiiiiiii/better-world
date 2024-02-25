import 'package:envawareness/utils/radient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zflutter/zflutter.dart';

class DashZdog extends ConsumerStatefulWidget {
  const DashZdog({
    super.key,
    this.rotate = const ZVector.only(),
    this.translate = const ZVector.all(0),
    this.scale = 1,
    this.speed = 5,
  });
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

  late MovieTween flyTween;

  MovieTween createOrbitTween(
    Offset start,
    Offset end,
    double maxScale,
    double rotate,
  ) {
    const duration = Duration(seconds: 2);
    const halfDuration = Duration(milliseconds: 1000);

    return MovieTween()
      ..tween(
        'x',
        Tween<double>(begin: start.dx, end: end.dx),
        duration: duration,
      )
      ..tween(
        'y',
        Tween<double>(begin: start.dy, end: end.dy),
        duration: duration,
        curve: Curves.easeInOut,
      )
      ..tween(
        'scale',
        Tween<double>(begin: 1, end: maxScale),
        duration: halfDuration,
      )
      ..tween(
        'scale',
        Tween<double>(begin: maxScale, end: 1),
        duration: halfDuration,
        begin: halfDuration,
      )
      ..tween(
        'z',
        Tween<double>(begin: 0, end: -rotate),
        duration: halfDuration,
      )
      ..tween(
        'z',
        Tween<double>(begin: -rotate, end: 0),
        duration: halfDuration,
        begin: halfDuration,
      );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    flyTween = createOrbitTween(
      const Offset(-100, -100),
      const Offset(100, 100),
      1.5,
      43.toRadius(),
    );

    updateFlipWings();
  }

  void updateFlipWings() {
    Future.delayed(const Duration(), () {
      if (mounted) {
        animationController.forward(from: 0).whenComplete(updateFlipWings);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashAnimations = List<Animation<double>>.generate(
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
      ),
    );
    return CustomAnimationBuilder(
      tween: flyTween,
      duration: const Duration(seconds: 6),
      curve: Curves.easeInOut,
      control: Control.loop,
      builder: (context, value, _) {
        return AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            final dash = dashAnimations.fold<double>(
              0,
              (previousValue, element) => previousValue + element.value,
            );
            return ZPositioned(
              rotate: widget.rotate.copyWith(
                y: widget.rotate.y + value.get('z'),
              ),
              // rotate: controller.rotate,
              translate: widget.translate.copyWith(
                // y: widget.translate.y + value.get('y'),
                // x: widget.translate.x + value.get('x'),
                y: -100,
                x: -100,
                z: widget.translate.z + dash,
              ),
              child: Dash(flight: dash),
            );
          },
        );
      },
    );
  }
}

const Color darkBlue = Color(0xff5CC0EF);

const Color bodyColor = Color(0xffa0e6fe);

const Color brown = Color(0xff967C40);

const Color green = Color(0xff71d3c7);

const Color black = Color(0xff000000);

class Dash extends StatelessWidget {
  const Dash({required this.flight, super.key});
  final double flight;

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: ZVector.only(y: flight, z: 50),
      child: ZGroup(
        children: [
          ZShape(
            stroke: 40,
            fill: true,
            color: bodyColor,
          ),
          ZPositioned(translate: const ZVector.only(y: -20), child: hair()),
          ZPositioned(
            translate: const ZVector.only(y: 12, z: -17),
            child: ZShape(
              stroke: 2,
              fill: true,
              path: [
                const ZMove.vector(
                  ZVector.only(),
                ),
                ZArc.list(
                  [
                    const ZVector.only(x: 5, y: -10, z: -8),
                    const ZVector.only(x: 8, y: -15, z: -10),
                  ],
                ),
                ZArc.list(
                  [
                    const ZVector.only(y: -25, z: -12),
                    const ZVector.only(x: -8, y: -15, z: -10),
                  ],
                ),
                ZArc.list(
                  [
                    const ZVector.only(x: -5, y: -10, z: -8),
                    const ZVector.only(y: -0),
                  ],
                ),
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
                translate: const ZVector.only(z: 2),
                child: ZShape(
                  stroke: 2,
                  fill: true,
                  path: [
                    const ZMove.vector(
                      ZVector.only(z: 20),
                    ),
                    ZArc.list(
                      [
                        const ZVector.only(x: -30, y: 7, z: 15),
                        const ZVector.only(y: 15, z: 15),
                      ],
                    ),
                    ZArc.list(
                      [
                        const ZVector.only(x: 30, y: 7, z: 15),
                        const ZVector.only(z: 20),
                      ],
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
              ZPositioned(
                translate: const ZVector.only(z: 20),
                child: ZGroup(
                  sortMode: SortMode.update,
                  children: [
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Todo: Migrate to widget system and use StatelessWidgets instead of functions
ZGroup hair() => ZGroup(
      children: [
        ZPositioned(
          translate: const ZVector.only(y: -1),
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
  return ZGroup(
    sortMode: SortMode.stack,
    children: [
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
        translate: translate + const ZVector.only(z: 0.1),
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
          fill: true,
          diameter: 1,
          color: Colors.white,
        ),
      ),
    ],
  );
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
          ),
        ),
      ],
    );
