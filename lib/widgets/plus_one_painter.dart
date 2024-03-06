import 'dart:async';

import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlusOneEntry {
  PlusOneEntry(this.position)
      : creationTime = DateTime.now(),
        duration = const Duration(milliseconds: 1500);
  final Offset position;
  final DateTime creationTime;
  final Duration duration;

  double get opacity {
    final remaining = DateTime.now().difference(creationTime).inMilliseconds /
        duration.inMilliseconds;
    return (1.0 - remaining).clamp(0.0, 1.0);
  }

  bool get isExpired => DateTime.now().difference(creationTime) >= duration;
}

class TapPlusOneDemo extends ConsumerStatefulWidget {
  const TapPlusOneDemo({super.key, this.tapPosition});
  final Offset? tapPosition;

  @override
  _TapPlusOneDemoState createState() => _TapPlusOneDemoState();
}

class _TapPlusOneDemoState extends ConsumerState<TapPlusOneDemo> {
  List<PlusOneEntry> entries = [];
  Timer? timer;

  @override
  void didUpdateWidget(covariant TapPlusOneDemo oldWidget) {
    if (widget.tapPosition != null &&
        widget.tapPosition != oldWidget.tapPosition) {
      entries.add(PlusOneEntry(widget.tapPosition!));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    if (widget.tapPosition != null) {
      entries.add(PlusOneEntry(widget.tapPosition!));
    }

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        entries.removeWhere((entry) => entry.isExpired);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(playControllerProvider).requireValue;
    final playInfo = gameState.playInfo;

    final validProductScore = gameState.getValidProductScore();
    final scorePerSecond = playInfo.perClickScore + validProductScore;
    return CustomPaint(
      painter: PlusOnePainter(
        entries,
        scorePerSecond,
        Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
      ),
      child: const SizedBox.shrink(),
    );
  }
}

class PlusOnePainter extends CustomPainter {
  PlusOnePainter(this.entries, this.scorePerSecond, this.textStyle);
  final List<PlusOneEntry> entries;
  final TextStyle textStyle;
  final int scorePerSecond;
  @override
  void paint(Canvas canvas, Size size) {
    for (final entry in entries) {
      final textSpan = TextSpan(
        text: '+$scorePerSecond',
        style: textStyle.copyWith(
          color: textStyle.color!.withOpacity(entry.opacity),
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      // ignore: cascade_invocations
      textPainter.layout();
      final offset = Offset(
        entry.position.dx - textPainter.width / 2,
        entry.position.dy - textPainter.height * 4 + entry.opacity * 20,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
