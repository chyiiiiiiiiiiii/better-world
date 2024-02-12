import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticleArea extends ConsumerStatefulWidget {
  const ParticleArea({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ParticleAreaState();
}

class _ParticleAreaState extends ConsumerState<ParticleArea> {
  Path drawCircle(Size size) {
    final radius = min(size.width, size.height) /
        2; // Assuming you want the circle to fit within the size
    final center =
        Offset(size.width / 2, size.height / 2); // Center of the circle
    final path = Path();

    // Adding a circle to the path
    path.addOval(Rect.fromCircle(center: center, radius: radius));

    return path;
  }

  @override
  Widget build(BuildContext context) {
    final confetitiController = ref.read(confettiControllerProvider);
    return Center(
      child: ConfettiWidget(
        confettiController: confetitiController,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 30,
        minBlastForce: 10,
        maximumSize: const Size(15, 6),
        minimumSize: const Size(5, 3),
        gravity: 0.1,
        colors: const [
          Color.fromARGB(255, 76, 148, 79),
          Color.fromARGB(255, 49, 137, 209),
        ], // manually specify the colors to be used
        // createParticlePath: drawStar, // define a custom shape/path.
        createParticlePath: drawCircle, // define a custom shape/path.
      ),
    );
  }
}
