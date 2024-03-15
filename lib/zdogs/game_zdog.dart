import 'package:envawareness/controllers/earth_controller.dart';
import 'package:envawareness/features/play/game_level_widgets.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:envawareness/widgets/plus_one_painter.dart';
import 'package:envawareness/zdogs/earth_zdog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zflutter/zflutter.dart';

class GameZdog extends ConsumerStatefulWidget {
  const GameZdog({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EarthZDogState();
}

class _EarthZDogState extends ConsumerState<GameZdog> {
  Control control = Control.stop; // define variable

  final earthClickTween = MovieTween()
    ..tween(
      'zoom',
      Tween<double>(begin: 1, end: 0.88),
      duration: const Duration(milliseconds: 100),
    )
    ..tween(
      'zoom',
      Tween<double>(begin: 0.88, end: 1),
      duration: const Duration(milliseconds: 100),
      begin: const Duration(milliseconds: 100),
    );

  final earthFlipTween = MovieTween()
    ..tween(
      'zoom',
      Tween<double>(begin: 1, end: 3.5),
      duration: const Duration(milliseconds: 100),
    )
    ..tween(
      'rotate',
      Tween<double>(begin: 0, end: 3),
      duration: const Duration(milliseconds: 100),
    )
    ..tween(
      'translate',
      Tween<double>(begin: 0, end: 40),
      duration: const Duration(milliseconds: 100),
    );

  void _toggleDirection() {
    setState(() {
      // let the animation play to the opposite direction
      control = control == Control.play ? Control.playReverse : Control.play;
    });
  }

  // for change edit mode in the first time, we need to set initial value
  bool changingEditMode = false;
  final double _rotationX = 0;
  final double _rotationY = 0;
  Offset? tapPosition;
  List<PlusOneEntry> entries = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final leaderBoardControl =
        ref.watch(leaderBoardAnimationControllerProvider);
    final editMode = ref.watch(editModeProvider);

    final gameState = ref.watch(playControllerProvider).requireValue;
    final levelInfo = gameState.levelInfo;

    return AppTap(
      onTap: () {
        ref.read(playControllerProvider.notifier).onEarthTap();
        _toggleDirection();
      },
      onTapUp: (details) {
        tapPosition = details.globalPosition;
        if (tapPosition != null) {
          entries.add(PlusOneEntry(tapPosition!));
        }
        setState(() {});
      },
      child: CustomAnimationBuilder<Movie>(
        tween: earthFlipTween,
        control: leaderBoardControl,
        duration: const Duration(milliseconds: 800),
        builder: (context, earthFlipMovie, __) {
          final rotate = ZVector.only(y: earthFlipMovie.get('rotate'));
          return CustomAnimationBuilder<Movie>(
            tween: earthClickTween,
            control: control,
            duration: const Duration(milliseconds: 150),
            builder: (context, value, __) {
              return Stack(
                children: [
                  ZDragDetector(
                    builder: (context, zDragController) {
                      if (changingEditMode) {
                        zDragController.value = ZVector.zero;
                        changingEditMode = false;
                      }

                      final dynamicRotate = zDragController.rotate;
                      // final dynamicRotate = (kIsWeb || kDebugMode)
                      //     ? zDragController.rotate
                      //     : ZVector.only(
                      //         y: (-(_rotationX - 130) * 0.7)
                      //             .clamp(
                      //               -30,
                      //               30,
                      //             )
                      //             .toRadius(),
                      //         x: ((_rotationY + 20) * 0.7)
                      //             .clamp(-30, 30)
                      //             .toRadius(),
                      //       );

                      final rotateValue = editMode ? dynamicRotate : rotate;

                      return ZIllustration(
                        zoom: (earthFlipMovie.get('zoom') as double) + 0.3,
                        children: [
                          ZPositioned(
                            rotate: rotateValue,
                            scale: ZVector.all(value.get('zoom')),
                            translate: ZVector.only(
                              y: earthFlipMovie.get('translate'),
                            ),
                            child: EarthZdog(rotateValue: rotateValue),
                          ),
                          ZPositioned(
                            rotate: rotateValue,
                            translate: ZVector.only(
                              y: earthFlipMovie.get('translate'),
                            ),
                            child: ZGroup(
                              children: [
                                ...getLevelWidget(levelInfo.level),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  TapPlusOneDemo(entries: entries),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class CloudPieceZdog extends StatelessWidget {
  const CloudPieceZdog({
    super.key,
    this.offset = Offset.zero,
    this.width = 10,
    this.zIndex = 100,
    this.stroke = 30,
  });
  final Offset offset;
  final double width;
  final double zIndex;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      path: [
        ZMove.only(x: offset.dx, y: offset.dy, z: zIndex),
        ZLine.only(x: offset.dx + width, y: offset.dy, z: zIndex),
      ],
      stroke: stroke,
      color: Colors.white,
    );
  }
}

class PlanteZdog extends StatelessWidget {
  const PlanteZdog({
    required this.paths,
    this.color = const Color.fromARGB(255, 120, 204, 97),
    super.key,
  });

  final List<ZPathCommand> paths;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ZShape(
      path: paths,
      fill: true,
      stroke: 20,
      color: color,
    );
  }
}
