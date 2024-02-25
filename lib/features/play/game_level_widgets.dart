import 'package:envawareness/utils/radient.dart';
import 'package:envawareness/zdogs/dash_zdog.dart';
import 'package:envawareness/zdogs/earth_zdog.dart';
import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

List<Widget?> levelWidgets = <Widget?>[
  // level 0
  null,
  // level 1
  const SunZdog(
    translate: ZVector.only(
      y: -100,
      x: 100,
      z: -10,
    ),
  ),
  // level 2
  WindTurbinesZdog(
    translate: const ZVector.only(
      y: -5,
      x: 98,
      z: 80,
    ),
    rotate: ZVector.only(
      x: 0.toRadius(),
      z: 90.toRadius(),
      y: -50.toRadius(),
    ),
  ),
  // level 3
  // TriangleTreeZdog(
  //   translate: const ZVector.only(
  //     y: -105,
  //   ),
  //   rotate: ZVector.only(
  //     x: 90.toRadius(),
  //   ),
  // ),
  // level 4
  CircleTreeZdog(
    translate: const ZVector.only(
      y: 60,
      x: -53,
      z: 33,
    ),
    rotate: ZVector.only(
      x: -30.toRadius(),
      y: 10.toRadius(),
    ),
  ),
  // CircleTreeZdog(
  //   translate: const ZVector.only(
  //     y: -105,
  //     x: 10,
  //     z: 20,
  //   ),
  //   rotate: ZVector.only(
  //     x: 90.toRadius(),
  //   ),
  // ),
  // level 5
  SolarPanel(
    translate: const ZVector.only(
      y: -60,
      x: -55,
      z: 90,
    ),
    rotate: ZVector.only(
      x: 30.toRadius(),
      z: 120.toRadius(),
    ),
  ),
  // level 6
  const DashZdog(),
  // level 7
  TriangleTreeZdog(
    translate: const ZVector.only(
      y: 83,
      x: -46,
      z: 30,
    ),
    rotate: ZVector.only(
      x: -60.toRadius(),
      y: 20.toRadius(),
    ),
  ),
  // level 8
];

List<Widget> getLevelWidget(int level) {
  final widgets = <Widget>[];
  try {
    for (var i = 0; i < level; i++) {
      if (i < levelWidgets.length) {
        final levelWidget = levelWidgets[i];
        if (levelWidget != null) {
          widgets.add(levelWidget);
        }
      }
    }
  } catch (e) {
    debugPrint('=======e : $e=========');
  }

  return widgets;
}
