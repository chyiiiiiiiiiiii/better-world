import 'dart:math';

import 'package:envawareness/constants/endangered_specise_data.dart';
import 'package:envawareness/data/endangered_species_info.dart';
import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/repositories/game_repository.dart';
import 'package:envawareness/repositories/store_repository.dart';
import 'package:envawareness/states/store_state.dart';
import 'package:envawareness/utils/game_helper.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_controller.g.dart';

@riverpod
class StoreController extends _$StoreController {
  String get _userId => ref.watch(authRepositoryProvider).userId;
  @override
  Future<StoreState> build() async {
    final currentLevel = await ref.watch(
      playControllerProvider.selectAsync(
        (data) => data.playInfo.currentLevel,
      ),
    );

    final animalCardPrice = calculateGamePerItemScore(
      currentLevel: currentLevel,
      numItems: 1,
      maxScoreProportionToTotalScore: 0.4,
    );

    return StoreState(
      animalCardPrice: animalCardPrice.toInt(),
    );
  }

  Future<void> purchase({required Product product}) async {
    try {
      final availableScore =
          ref.read(playControllerProvider).requireValue.playInfo.availableScore;
      if (availableScore < product.price) {
        final l10n = await getL10n();
        ref.read(showMessageProvider.notifier).show(l10n.noAvailableScore);

        return;
      }

      final purchaseHistory = PurchaseHistory(
        userId: _userId,
        productId: product.id,
        productType: product.type.name,
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

      final playInfo = ref.read(playControllerProvider).requireValue.playInfo;
      final newPlayInfo = playInfo.copyWith(
        usedScore: playInfo.usedScore + product.price,
      );

      await ref
          .read(playControllerProvider.notifier)
          .updatePlayInfo(newPlayInfo);
      await ref
          .read(gameRepositoryProvider)
          .updatePlayInfo(playInfo: newPlayInfo);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<EndangeredSpeciesInfo?> purchaseAnimalCard() async {
    try {
      final l10n = await getL10n();

      final availableScore =
          ref.read(playControllerProvider).requireValue.playInfo.availableScore;
      final animalCardPrice = state.requireValue.animalCardPrice;

      if (availableScore < animalCardPrice) {
        ref.read(showMessageProvider.notifier).show(l10n.noAvailableScore);

        return null;
      }

      final products = endangeredSpeciesList;
      final animalCardIndex = Random().nextInt(products.length);
      final endangeredSpeciesInfo = products.elementAt(animalCardIndex);
      final animalName = endangeredSpeciesInfo.translatedName;

      final purchaseHistory = PurchaseHistory(
        userId: _userId,
        productId: '''
                animal-card-$animalCardIndex-${endangeredSpeciesInfo.nameEn.toLowerCase().split(' ').join('-')}
            ''',
        productType: ProductType.species.name,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        endAt: 0,
      );

      await ref.read(storeRepositoryProvider).purchase(
            purchaseHistory: purchaseHistory,
          );

      final playInfo = ref.read(playControllerProvider).requireValue.playInfo;
      final newOwnedAnimalCardIndexes = playInfo.ownedAnimalCardIndexes.toSet()
        ..add(animalCardIndex);
      final newAnimalCardDrawCount = playInfo.animalCardDrawCount + 1;

      final hasDrewExistCard =
          playInfo.ownedAnimalCardIndexes.contains(animalCardIndex);
      if (hasDrewExistCard) {
        ref
            .read(showMessageProvider.notifier)
            .show(l10n.speciesAlreadyGot(animalName));
      }

      final newPlayInfo = playInfo.copyWith(
        usedScore: playInfo.usedScore + animalCardPrice,
        ownedAnimalCardIndexes: newOwnedAnimalCardIndexes.toList(),
        animalCardDrawCount: newAnimalCardDrawCount,
      );

      await ref
          .read(playControllerProvider.notifier)
          .updatePlayInfo(newPlayInfo);
      await ref
          .read(gameRepositoryProvider)
          .updatePlayInfo(playInfo: newPlayInfo);

      return hasDrewExistCard ? null : endangeredSpeciesInfo;
    } catch (error) {
      debugPrint(error.toString());

      return null;
    }
  }
}
