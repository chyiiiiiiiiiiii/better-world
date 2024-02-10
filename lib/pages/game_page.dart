import 'package:envawareness/features/home/home_screen.dart';
import 'package:envawareness/features/home/particle.dart';
import 'package:envawareness/features/home/trash_monster.dart';
import 'package:envawareness/zdogs/dash_zdog.dart';
import 'package:envawareness/zdogs/earth_zdog.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const routePath = '/';

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Stack(
        children: [
          ParticleArea(),
          EarthZdog(),
          HomeScreen(),
          IgnorePointer(child: DashZdog()),
          TrashMonster(),
        ],
      ),
    );
  }
}
