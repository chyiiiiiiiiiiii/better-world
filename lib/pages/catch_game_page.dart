import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:audioplayers/audioplayers.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/game_helper.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/recycle_icon.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrashCan {
  TrashCan({
    this.positionX = 200,
    this.width = 50.0,
  });
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
  bool startGame = false;
  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  Future<void> asyncInit() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('firstTimeEnterCatchGame', false);
    if (prefs.getBool('firstTimeEnterCatchGame') ?? true) {
      if (mounted) {
        await showDialog<void>(
          context: context,
          builder: (_) {
            return CatchGameTutorailDialog(context: context, prefs: prefs);
          },
        );
      }
    }
    setState(() {
      startGame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        // painter
        body: startGame ? const GameWidget() : const SizedBox(),
      ),
    );
  }
}

class CatchGameTutorailDialog extends StatefulWidget {
  const CatchGameTutorailDialog({
    required this.context,
    required this.prefs,
    super.key,
  });

  final BuildContext context;
  final SharedPreferences prefs;

  @override
  State<CatchGameTutorailDialog> createState() =>
      _CatchGameTutorailDialogState();
}

class _CatchGameTutorailDialogState extends State<CatchGameTutorailDialog> {
  bool dontShowAgain = false;

  void onCheckBoxTap(bool? value) {
    final doNotShow = value ?? false;
    widget.prefs.setBool('firstTimeEnterCatchGame', !doNotShow);

    setState(() {
      dontShowAgain = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.catchGameTutorialTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.catchGameTutorialMessage,
          ),
          Gaps.h20,

          Text(
            l10n.catchGameTutorialRecyclable,
            style: context.theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.h8,
          Row(
            children: [
              Image.asset(
                'assets/images/game/re_0.png',
                width: 50,
                height: 50,
              ),
              Gaps.w12,
              Image.asset(
                'assets/images/game/re_1.png',
                width: 50,
                height: 50,
              ),
              Gaps.w12,
              Image.asset(
                'assets/images/game/re_2.png',
                width: 50,
                height: 50,
              ),
              Gaps.w12,
              Image.asset(
                'assets/images/game/re_3.png',
                width: 50,
                height: 50,
              ),
            ],
          ),
          Gaps.h8,
          Text(
            l10n.catchGameTutorialNotRecyclable,
            style: context.theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/game/re_4.png',
                width: 50,
                height: 50,
              ),
              Gaps.w12,
              Image.asset(
                'assets/images/game/re_5.png',
                width: 50,
                height: 50,
              ),
              Gaps.w12,
              Image.asset(
                'assets/images/game/re_6.png',
                width: 50,
                height: 50,
              ),
            ],
          ),
          // dont show again
          Gaps.h12,
          GestureDetector(
            onTap: () => onCheckBoxTap(!dontShowAgain),
            child: Row(
              children: [
                Checkbox(
                  value: dontShowAgain,
                  onChanged: onCheckBoxTap,
                ),
                Text(
                  l10n.catchGameTutorialDoNotShow,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(l10n.catchGameTutorialConfirm),
        ),
      ],
    );
  }
}

class GameWidget extends ConsumerStatefulWidget {
  const GameWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends ConsumerState<GameWidget>
    with TickerProviderStateMixin {
  late GameState _gameState;

  Timer? refreshTimer;
  Map<int, ui.Image> images = {};
  bool isFinished = false;

  late AnimationController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Timer? _timer;
  int _countdownSeconds = 40;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdownSeconds == 0) {
          setState(() {
            onFinished();
            timer.cancel();
          });
        } else {
          setState(() {
            _countdownSeconds--;
          });
        }
      },
    );
  }

  Future<void> onFinished() async {
    final currentLevel =
        ref.read(playControllerProvider).requireValue.playInfo.currentLevel;
    final perAddScore = calculateGamePerItemScore(
      currentLevel: currentLevel,
      numItems: 50,
      maxScoreProportionToTotalScore: 0.25,
    );
    final totalScore = max((_gameState.score * perAddScore).toInt(), 0);

    await ref
        .read(playControllerProvider.notifier)
        .updateClickCount(needReset: true);
    await ref
        .read(playControllerProvider.notifier)
        .updateMyScore(extraScore: totalScore);

    setState(() {
      _gameState.totalScore = totalScore;
      isFinished = true;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    refreshTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      // 約每16毫秒更新一次，相當於60FPS
      setState(() {
        final screenHeight = MediaQuery.sizeOf(context).height;
        updateBallPositions(screenHeight);
      });
    });
    loadImage();
    startTimer();
    super.initState();
  }

  Future<void> catched({required bool isRecyclable}) async {
    _controller
      ..reset()
      ..forward();
    await _audioPlayer.stop();
    await HapticFeedback.lightImpact();
    if (isRecyclable) {
      await _audioPlayer.play(AssetSource('sounds/trash_in.wav'));
    } else {
      await _audioPlayer.play(AssetSource('sounds/wrong_trash_in.wav'));
    }
  }

  List<Ball> generateRandomBalls(int count, double screenWidth) {
    final balls = <Ball>[];
    final random = Random();

    for (var i = 0; i < count; i++) {
      final positionX = random.nextDouble() * screenWidth;
      final positionY = -random.nextDouble() * 10000;
      final speed = random.nextDouble() * 3 + 1;

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
      final ImageProvider provider = AssetImage('assets/images/game/re_$i.png');
      final stream = provider.resolve(ImageConfiguration.empty);
      final listener = ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          images[i] = info.image;
        });
      });

      stream.addListener(listener);
    }
  }

  @override
  void didChangeDependencies() {
    final screenWidth = MediaQuery.of(context).size.width;
    _gameState = GameState(screenWidth: screenWidth)
      ..balls = generateRandomBalls(100, screenWidth);
    super.didChangeDependencies();
  }

  void updateBallPositions(double screenHeight) {
    if (isFinished) return;
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
          (ball.positionY + ball.radius >= screenHeight - 110) &&
              (ball.positionY + ball.radius <= screenHeight - 70);

      if (withinHorizontalRange && hitTrashCan) {
        // 碰撞發生，增加分數並標記球移除
        ball.isRecyclable ? _gameState.score += 2 : _gameState.score -= 1;
        ballsToRemove.add(ball);
        catched(isRecyclable: ball.isRecyclable);
      }

      _gameState.balls.removeWhere(ballsToRemove.contains);

      // 可選：檢查球是否超出屏幕底部，並相應處理（比如重置位置或移除球）
      if (ball.positionY > screenHeight) {
        // 這裡可以根據遊戲邏輯來重置或移除球
        ball.positionY = -1000; // 例如，重置到屏幕頂部
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    refreshTimer?.cancel();

    _timer = null;
    refreshTimer = null;

    _controller.dispose();
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _gameState.moveTrashCan(details.delta.dx);
        });
      },
      child: Stack(
        children: [
          if (!isFinished)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        l10n.score,
                        style: context.theme.textTheme.headlineSmall,
                      ),
                      Text(
                        _gameState.score.toString(),
                        style: context.theme.textTheme.headlineLarge
                            ?.copyWith(color: context.colorScheme.secondary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_countdownSeconds',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Gaps.w4,
                          Image.asset(
                            'assets/images/hourglass.png',
                            width: 48,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (images.length < 7) // 確保圖片加載完成
            Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    '${l10n.catchGameTutorialLoading}... ${images.length}/7',
                  ),
                ],
              ),
            )
          else if (!isFinished)
            CustomPaint(
              size: Size.infinite,
              painter: GamePainter(
                images,
                trashCan: _gameState.trashCan,
                balls: _gameState.balls,
              ),
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${l10n.environmentalScore}:',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const RecycleIcon(
                        size: 36,
                      ),
                      Gaps.w8,
                      Text(
                        _gameState.totalScore.toString(),
                        style: context.textTheme.displayLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  DefaultButton(
                    onPressed: () {
                      context.go('/');
                    },
                    text: l10n.recyclableGameGetReward,
                  ),
                ],
              ),
            ),
          if (!isFinished) ...[
            Positioned(
              left: _gameState.trashCan.positionX - 5,
              bottom: 60,
              child: SizedBox(
                width: 60,
                child: LottieBuilder.asset(
                  'assets/animations/trash_can.json',
                  width: _gameState.trashCan.width,
                  controller: _controller,
                  fit: BoxFit.fill,
                  repeat: false,
                  onLoaded: (composition) {
                    // Set the controller bounds based on the animation duration.
                    _controller.duration = composition.duration;
                  },
                ),
              ),
            ),
            const SafeArea(child: AppCloseButton()),
          ],
        ],
      ),
    );
  }
}

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacings.px20),
          child: Icon(Icons.close),
        ),
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  GamePainter(this.images, {required this.trashCan, required this.balls});
  final TrashCan trashCan;
  final List<Ball> balls;
  final Map<int, ui.Image> images;

  void paintTrashCan(Canvas canvas, Size size, TrashCan trashCan) {
    final paint = Paint()
      ..color = Colors.transparent
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
      if (images[ball.imageIndex] == null) return;
      final ballPaint = Paint()
        ..colorFilter = ColorFilter.mode(
          ball.isRecyclable
              ? const ui.Color.fromARGB(255, 247, 255, 247)
              : const ui.Color.fromARGB(
                  255,
                  255,
                  159,
                  159,
                ), // The color to apply
          BlendMode.modulate, // The blend mode to use
        );
      final src = Rect.fromLTWH(
        0,
        0,
        images[ball.imageIndex]!.width.toDouble(),
        images[ball.imageIndex]!.height.toDouble(),
      );

      final dst = Rect.fromCircle(
        center: Offset(ball.positionX, ball.positionY),
        radius: 30,
      );
      canvas.drawImageRect(
        images[ball.imageIndex]!,
        src,
        dst,
        ballPaint,
      );
    }
    // for debug
    if (kDebugMode) {
      for (final ball in balls) {
        final ballPaint = Paint()
          ..color = ball.isRecyclable ? Colors.green : Colors.red;
        canvas.drawCircle(
          Offset(ball.positionX, ball.positionY),
          ball.radius,
          ballPaint,
        );
      }
    }
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
  int totalScore = 0;

  double screenWidth;

  void moveTrashCan(double dx) {
    final newPositionX = trashCan.positionX + dx;
    // Ensure the trash can does not move beyond the screen width
    if (newPositionX >= 0 && newPositionX <= screenWidth - trashCan.width) {
      trashCan.positionX = newPositionX;
    }
  }
}
