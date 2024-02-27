import 'dart:math';

import 'package:envawareness/constants/endangered_specise_data.dart';
import 'package:envawareness/data/endangered_species_info.dart';
import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/repositories/game_repository.dart';
import 'package:envawareness/repositories/store_repository.dart';
import 'package:flutter/material.dart';
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
    try {
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
      final availableScore =
          ref.read(playControllerProvider).requireValue.playInfo.availableScore;
      final animalCardPrice = ref
          .watch(playControllerProvider)
          .requireValue
          .playInfo
          .animalCardPrice;

      if (availableScore < animalCardPrice) {
        ref
            .read(showMessageProvider.notifier)
            .show('No available score for purchase.');

        return null;
      }

      final products = endangeredSpecies;
      final animalCardIndex = Random().nextInt(products.length);
      final endangeredSpeciesInfo = products.elementAt(animalCardIndex);
      final animalName = endangeredSpeciesInfo.name;

      final purchaseHistory = PurchaseHistory(
        userId: _userId,
        productId: 'animal-card-$animalCardIndex',
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
            .show("The animal \n '$animalName' \nYou have got it.");
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
