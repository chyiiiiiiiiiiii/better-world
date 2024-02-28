import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:envawareness/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    this.imageIndex = 0,
    this.isRecyclable = false,
  });
  double positionX;
  double positionY;
  double radius;
  double speed;
  int imageIndex;
  bool isRecyclable;
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
    return const PopScope(
      canPop: false,
      child: Scaffold(
        // painter
        body: SafeArea(
          child: GameWidget(),
        ),
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
  List<ui.Image> images = [];

  @override
  void initState() {
    refreshTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      // 約每16毫秒更新一次，相當於60FPS
      setState(() {
        final screenHeight = MediaQuery.of(context).size.height;
        updateBallPositions(screenHeight);
      });
    });
    loadImage();
    super.initState();
  }

  List<Ball> generateRandomBalls(int count, double screenWidth) {
    final balls = <Ball>[];
    final random = Random();

    for (var i = 0; i < count; i++) {
      // 生成随机位置
      final positionX = random.nextDouble() * screenWidth;
      final positionY = -random.nextDouble() * 5000;
      final speed = random.nextDouble() * 3 + 1;

      // 生成随机的 isRecyclable 状态
      final isRecyclable = random.nextBool();

      // 根据 isRecyclable 状态分配 image 索引
      int imageIndex;
      if (isRecyclable) {
        imageIndex = random.nextInt(4); // 生成 0 到 3 的随机数
      } else {
        imageIndex = 4 + random.nextInt(3); // 生成 4 到 6 的随机数
      }

      // 创建 Ball 对象并添加到列表中
      balls.add(
        Ball(
          speed: speed,
          positionX: positionX,
          positionY: positionY,
          isRecyclable: isRecyclable,
          imageIndex: imageIndex,
        ),
      );
    }

    return balls;
  }

  void loadImage() {
    for (var i = 0; i < 7; i++) {
      final ImageProvider provider =
          AssetImage('assets/images/game/re_$i.png'); // 例如使用資源圖像
      final stream = provider.resolve(ImageConfiguration.empty);
      final listener = ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          images.add(info.image);
        });
      });

      stream.addListener(listener);
    }
  }

  @override
  void didChangeDependencies() {
    final screenWidth = MediaQuery.of(context).size.width;
    _gameState = GameState(screenWidth: screenWidth)
      ..balls = generateRandomBalls(60, screenWidth);
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
        ball.isRecyclable ? _gameState.score += 2 : _gameState.score -= 1;
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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    'Score',
                    style: context.theme.textTheme.headlineSmall,
                  ),
                  Text(
                    _gameState.score.toString(),
                    style: context.theme.textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          if (images.length < 7) // 確保圖片加載完成
            Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  Text('Loading... ${images.length}/7'),
                ],
              ),
            )
          else
            CustomPaint(
              size: Size.infinite,
              painter: GamePainter(
                images,
                trashCan: _gameState.trashCan,
                balls: _gameState.balls,
              ),
            ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Padding(
                padding: EdgeInsets.all(24),
                child: Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  GamePainter(this.images, {required this.trashCan, required this.balls});
  final TrashCan trashCan;
  final List<Ball> balls;
  final List<ui.Image> images;

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

  void paintBalls(Canvas canvas, Size size, List<Ball> balls) {
    for (final ball in balls) {
      final ballPaint = Paint();
      final src = Rect.fromLTWH(
        0,
        0,
        images[ball.imageIndex].width.toDouble(),
        images[ball.imageIndex].height.toDouble(),
      );

      final dst = Rect.fromCircle(
        center: Offset(ball.positionX, ball.positionY),
        radius: 30,
      );
      canvas.drawImageRect(
        images[ball.imageIndex],
        src,
        dst,
        ballPaint,
      );
    }
    // for debug
    // for (final ball in balls) {
    //   final ballPaint = Paint()
    //     ..color = ball.isRecyclable ? Colors.green : Colors.red;
    //   canvas.drawCircle(
    //     Offset(ball.positionX, ball.positionY),
    //     ball.radius,
    //     ballPaint,
    //   );
    // }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Paint trash can
    paintTrashCan(canvas, size, trashCan);
    // Paint balls
    paintBalls(canvas, size, balls);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // In a real game, optimize this condition
  }
}

class GameState {
  GameState({required this.screenWidth, this.balls = const []});

  final TrashCan trashCan = TrashCan();
  List<Ball> balls = [];
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
