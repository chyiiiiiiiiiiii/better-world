import 'package:flutter/material.dart';

class RecycleIcon extends StatelessWidget {
  const RecycleIcon({super.key, this.size = 16});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/recycling.png',
      width: size,
      height: size,
    );
  }
}
