import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final trashMonsterControllerProvider =
    NotifierProvider.autoDispose<TrashMonsterController, void>(
        TrashMonsterController.new);

class TrashMonsterController extends AutoDisposeNotifier<void> {
  void createMonster() {
    ref.read(trashMonsterNumberProvider.notifier).state = Random().nextInt(5);
    ref.read(trashMonsterLifeProvider.notifier).state =
        Random().nextInt(30) + 30;
    ref.read(isShowTrashMonsterProvider.notifier).state = true;
  }

  @override
  void build() {
    ref.listen(trashMonsterLifeProvider, (previous, next) {
      if (next <= 0) {
        ref.read(isShowTrashMonsterProvider.notifier).state = false;
      }
    });
    return;
  }
}

final trashMonsterLifeProvider = StateProvider<int>((ref) {
  return Random().nextInt(30) + 30;
});

final isShowTrashMonsterProvider = StateProvider<bool>((ref) {
  return false;
});

final trashMonsterNumberProvider = StateProvider<int>((ref) {
  return 0;
});
