import 'package:collection/collection.dart';
import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@freezed
class GameState with _$GameState {
  factory GameState({
    required PlayInfo playInfo,
    required LevelInfo levelInfo,
    required List<Product> products,
    required List<PurchaseHistory> validPurchases,
    required int levelTotalCount,
    required double finishProgress,
    @Default(0) int clickCount,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}

extension GameStateExtension on GameState {
  bool get canPlayRecycleGame => clickCount >= 20;

  List<Product> getValidPurchaseProducts() {
    final validPurchaseProducts = <Product>[];

    for (final validPurchase in validPurchases) {
      final product = products.firstWhereOrNull(
        (element) {
          final isSame = element.id == validPurchase.productId;
          final isExpired =
              validPurchase.endAt < DateTime.now().millisecondsSinceEpoch;

          return isSame && !isExpired;
        },
      );

      if (product == null) {
        continue;
      }

      validPurchaseProducts.add(product);
    }

    return validPurchaseProducts;
  }

  int getValidProductScore() {
    final products = getValidPurchaseProducts();
    return products.isNotEmpty
        ? getValidPurchaseProducts()
            .map(
              (e) => e.addScore,
            )
            .reduce(
              (previous, next) => previous + next,
            )
        : 0;
  }
}
