import 'package:envawareness/zdogs/cloud_zdog.dart';
import 'package:envawareness/zdogs/game_zdog.dart';
import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

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
