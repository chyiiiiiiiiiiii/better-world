import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/repositories/game_repository.dart';
import 'package:envawareness/repositories/store_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_controller.g.dart';

@riverpod
class StoreController extends _$StoreController {
  String get _userId => ref.watch(authRepositoryProvider).userId;
  @override
  Future<void> build() async {
    return;
  }

  Future<void> purchase({required Product product}) async {
    final availableScore =
        ref.read(playControllerProvider).requireValue.playInfo.availableScore;
    if (availableScore < product.price) {
      ref
          .read(showMessageProvider.notifier)
          .show('No available score for purchase.');

      return;
    }

    final purchaseHistory = PurchaseHistory(
      userId: _userId,
      productId: product.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      endAt: DateTime.now()
          .add(Duration(seconds: product.validTimeSeconds))
          .millisecondsSinceEpoch,
    );

    await ref.read(storeRepositoryProvider).purchase(
          purchaseHistory: purchaseHistory,
        );

    await ref
        .read(playControllerProvider.notifier)
        .addValidPurchase(purchaseHistory);

    await _updatePlayInfo(product: product);
  }

  Future<void> _updatePlayInfo({required Product product}) async {
    final playInfo = ref.read(playControllerProvider).requireValue.playInfo;
    final newPerClickScore = playInfo.perClickScore + product.addScore;
    final newPlayInfo = playInfo.copyWith(
      perClickScore: newPerClickScore,
      usedScore: playInfo.usedScore + product.price,
    );

    await ref
        .read(gameRepositoryProvider)
        .updatePlayInfo(playInfo: newPlayInfo);
  }
}
