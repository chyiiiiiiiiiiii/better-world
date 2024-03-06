import 'package:envawareness/utils/radient.dart';
import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

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
