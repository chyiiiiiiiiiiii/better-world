import 'package:flutter/material.dart';

class BackgroundShinning extends StatefulWidget {
  const BackgroundShinning({
    required this.child,
    this.isShinning = true,
    super.key,
  });

  final Widget child;
  final bool isShinning;

  @override
  State<BackgroundShinning> createState() => _BackgroundShinningState();
}

class _BackgroundShinningState extends State<BackgroundShinning>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      value: 0.5,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant BackgroundShinning oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.isShinning ? _controller.repeat(reverse: true) : _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (widget.isShinning)
                BoxShadow(
                  color: Colors.white.withAlpha(200),
                  blurRadius: _animation.value + 4,
                  spreadRadius: _animation.value,
                ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
