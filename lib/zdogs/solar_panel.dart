import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zflutter/zflutter.dart';

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
