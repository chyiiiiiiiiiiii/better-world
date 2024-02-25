import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RightSideView extends StatelessWidget {
  const RightSideView({
    required this.canPlayRecycleGame,
    super.key,
  });

  final bool canPlayRecycleGame;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: canPlayRecycleGame ? 1 : 0,
      duration: canPlayRecycleGame ? Durations.medium2 : Durations.short2,
      child: const RecycleWidget(),
    );
  }
}

class RecycleWidget extends StatefulWidget {
  const RecycleWidget({
    super.key,
  });

  @override
  State<RecycleWidget> createState() => _RecycleWidgetState();
}

class _RecycleWidgetState extends State<RecycleWidget>
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
      end: 20,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
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
            // gradient: RadialGradient(
            //   colors: [
            //     Colors.green.withOpacity(0),
            //     Colors.green.withOpacity(0.1),
            //     Colors.green.withOpacity(0.1),
            //   ],
            //   stops: [0.0, _animation.value + 0.3, 1.0],
            // ),
            boxShadow: [
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
      child: AppTap(
        onTap: () {
          context.push(RecycleGamePage.routePath);
        },
        child: Image.asset(
          'assets/images/recycle-bin.png',
          width: context.width / 6,
          height: context.width / 6,
        ),
      ),
    );
  }
}
