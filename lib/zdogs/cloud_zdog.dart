import 'package:envawareness/zdogs/game_zdog.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:zflutter/zflutter.dart';

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
