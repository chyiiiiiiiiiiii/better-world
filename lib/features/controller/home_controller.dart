import 'package:confetti/confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';

final homeControllerProvider =
    NotifierProvider<HomeController, void>(HomeController.new);

class HomeController extends Notifier<void> {
  void earthClicked() {
    final blockEarth = ref.read(isEarthBlockProvider);
    if (blockEarth) {
      return;
    }
    ref.read(pointControllerProvider.notifier).update();
    ref.read(confettiControllerProvider).stop();
    ref.read(confettiControllerProvider).play();
  }

  void leaderBoardClicked() {
    ref.read(isEarthBlockProvider.notifier).state =
        !ref.read(isEarthBlockProvider);

    ref.read(leaderBoardAnimationControllerProvider.notifier).toggle();
  }

  // update points every 1 seconds
  void updatePoints() {
    Future.delayed(const Duration(seconds: 1), () {
      final passivePoint = ref.read(passivePointProvider);
      ref.read(pointControllerProvider.notifier).update(
            value: passivePoint,
          );
      updatePoints();
    });
  }

  @override
  void build() {
    updatePoints();
    return;
  }
}

final passivePointProvider = StateProvider<double>((ref) {
  return 1.3;
});

final isEarthBlockProvider = StateProvider<bool>((ref) {
  return false;
});

final leaderBoardAnimationControllerProvider =
    NotifierProvider.autoDispose<ControllerNameController, Control>(
        ControllerNameController.new);

class ControllerNameController extends AutoDisposeNotifier<Control> {
  void toggle() {
    if (state == Control.stop) {
      state = Control.play;
    } else if (state == Control.playReverse) {
      state = Control.play;
    } else {
      state = Control.playReverse;
    }
  }

  void update(Control control) {
    state = control;
  }

  @override
  Control build() {
    return Control.stop;
  }
}

final confettiControllerProvider = Provider<ConfettiController>((ref) {
  final confettiController =
      ConfettiController(duration: const Duration(milliseconds: 20));

  return confettiController;
});

final pointControllerProvider =
    NotifierProvider<PointController, double>(PointController.new);

class PointController extends Notifier<double> {
  update({double? value}) {
    if (value != null) {
      state += value;
    } else {
      state = state + 1;
    }
  }

  @override
  double build() {
    return 0;
  }
}
