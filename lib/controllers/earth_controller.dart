import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earth_controller.g.dart';

@Riverpod(keepAlive: true)
class EditMode extends _$EditMode {
  void toggle() {
    state = !state;
  }

  @override
  bool build() {
    return false;
  }
}

final showTreesProvider = StateProvider<bool>((ref) {
  return false;
});
