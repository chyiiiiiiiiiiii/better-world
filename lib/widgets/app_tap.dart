import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTap extends StatefulWidget {
  const AppTap({
    required this.onTap,
    required this.child,
    this.hasEffect = true,
    super.key,
  });

  final VoidCallback onTap;
  final Widget child;
  final bool hasEffect;

  @override
  State<AppTap> createState() => _AppTapState();
}

class _AppTapState extends State<AppTap> {
  bool isPressing = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onTap.call(),
        onTapDown: (details) {
          setState(() {
            isPressing = true;
          });

          HapticFeedback.selectionClick();
        },
        onTapUp: (details) {
          setState(() {
            isPressing = false;
          });
        },
        onTapCancel: () {
          setState(() {
            isPressing = true;
          });
        },
        child: AnimatedScale(
          scale: (isPressing && widget.hasEffect) ? 0.95 : 1,
          duration: Durations.medium1,
          child: widget.child,
        ),
      ),
    );
  }
}
