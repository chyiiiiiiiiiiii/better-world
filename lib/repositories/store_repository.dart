import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:envawareness/firebase/firestore_collections_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_repository.g.dart';

class StoreRepository {
  StoreRepository({
    required this.purchaseHistoryCollectionReference,
  });

  final CollectionReference<PurchaseHistory> purchaseHistoryCollectionReference;

  Future<void> purchase({
    required PurchaseHistory purchaseHistory,
  }) async {
    await purchaseHistoryCollectionReference.add(
      purchaseHistory,
    );
  }

  Future<List<PurchaseHistory>> getValidPurchaseHistory() async {
    final query = purchaseHistoryCollectionReference
        .where(
          'end_at',
          isGreaterThan: DateTime.now().millisecondsSinceEpoch,
        )
        .orderBy('end_at');
    final snapshot = await query.get();
    final data = snapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();

    return data;
  }
}

@riverpod
StoreRepository storeRepository(StoreRepositoryRef ref) {
  return StoreRepository(
    purchaseHistoryCollectionReference:
        ref.watch(purchaseHistoryCollectionReferenceProvider),
  );
}
