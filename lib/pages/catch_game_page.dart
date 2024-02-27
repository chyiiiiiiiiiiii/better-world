import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrashCan {
  TrashCan({this.positionX = 0.0, this.width = 50.0});
  double positionX;
  double width;
}

class Ball {
  Ball({
    this.positionX = 0.0,
    this.positionY = 0.0,
    this.radius = 10.0,
    this.speed = 3.0,
  });
  double positionX;
  double positionY;
  double radius;
  double speed;
}

class CatchGamePage extends ConsumerStatefulWidget {
  const CatchGamePage({super.key});

  static const routePath = '/catch-game-page';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CatchGamePageState();
}

class _CatchGamePageState extends ConsumerState<CatchGamePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // painter
      body: SafeArea(
        child: GameWidget(),
      ),
    );
  }
}

class GameWidget extends ConsumerStatefulWidget {
  const GameWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends ConsumerState<GameWidget> {
  late GameState _gameState;

  Timer? refreshTimer;

  @override
  void initState() {
    refreshTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      // 約每16毫秒更新一次，相當於60FPS
      setState(() {
        final screenHeight = MediaQuery.of(context).size.height;
        updateBallPositions(screenHeight);
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _gameState = GameState(screenWidth: MediaQuery.of(context).size.width);
    super.didChangeDependencies();
  }

  void updateBallPositions(double screenHeight) {
    final ballsToRemove = <Ball>[];

    for (final ball in _gameState.balls) {
      // 更新球的垂直位置
      ball.positionY += ball.speed; // 球下落的速度，可以根據需要調整

      // 確定球是否在垃圾桶的水平範圍內
      final withinHorizontalRange =
          ball.positionX >= _gameState.trashCan.positionX &&
              ball.positionX <=
                  _gameState.trashCan.positionX + _gameState.trashCan.width;

      // 檢查球是否碰到垃圾桶的頂部
      final hitTrashCan =
          ball.positionY + ball.radius >= screenHeight - 120; // 假設垃圾桶的高度是固定的50

      if (withinHorizontalRange && hitTrashCan) {
        // 碰撞發生，增加分數並標記球移除
        _gameState.score += 1;
        ballsToRemove.add(ball);
      }

      _gameState.balls.removeWhere(ballsToRemove.contains);

      // 可選：檢查球是否超出屏幕底部，並相應處理（比如重置位置或移除球）
      if (ball.positionY > screenHeight) {
        // 這裡可以根據遊戲邏輯來重置或移除球
        ball.positionY = 0; // 例如，重置到屏幕頂部
      }
    }
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    refreshTimer = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _gameState.moveTrashCan(details.delta.dx);
        });
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: GamePainter(
          trashCan: _gameState.trashCan,
          balls: _gameState.balls,
        ),
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  GamePainter({required this.trashCan, required this.balls});
  final TrashCan trashCan;
  final List<Ball> balls;

  void paintTrashCan(Canvas canvas, Size size, TrashCan trashCan) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    const trashCanHeight = 50.0;
    final trashCanTop = size.height - trashCanHeight;
    const radius = Radius.circular(20);

    final path = Path()
      ..moveTo(trashCan.positionX, trashCanTop)
      ..lineTo(trashCan.positionX, size.height - radius.y)
      ..arcToPoint(
        Offset(trashCan.positionX + radius.x, size.height),
        radius: radius,
        clockwise: false,
      )
      ..lineTo(
        trashCan.positionX + trashCan.width - radius.x,
        size.height,
      )
      ..arcToPoint(
        Offset(trashCan.positionX + trashCan.width, size.height - radius.y),
        radius: radius,
        clockwise: false,
      )
      ..lineTo(trashCan.positionX + trashCan.width, trashCanTop);

    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Paint trash can
    paintTrashCan(canvas, size, trashCan);
    // Paint balls
    final ballPaint = Paint()..color = Colors.red;
    for (final ball in balls) {
      canvas.drawCircle(
        Offset(ball.positionX, ball.positionY),
        ball.radius,
        ballPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // In a real game, optimize this condition
  }
}

class GameState {
  GameState({required this.screenWidth});

  final TrashCan trashCan = TrashCan();
  final List<Ball> balls = [
    Ball(positionX: 100, positionY: 100),
    Ball(positionX: 200, positionY: 100, speed: 2.4),
    Ball(positionX: 300, positionY: 100),
  ];
  int score = 0;

  double screenWidth;

  void moveTrashCan(double dx) {
    final newPositionX = trashCan.positionX + dx;
    // Ensure the trash can does not move beyond the screen width
    if (newPositionX >= 0 && newPositionX <= screenWidth - trashCan.width) {
      trashCan.positionX = newPositionX;
    }
  }
}
