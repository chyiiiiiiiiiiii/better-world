import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/constants/firestore_collections.dart';
import 'package:envawareness/controllers/firestore_controller.dart';
import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/data/purchase_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_collections_provider.g.dart';

@Riverpod(keepAlive: true)
CollectionReference<LevelInfo> levelCollectionReference(
  LevelCollectionReferenceRef ref,
) {
  final firestore = ref.watch(fireStoreProvider);

  return firestore.collection(FirestoreCollections.level).withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) =>
            LevelInfo.fromJson(snapshot.data() ?? {}),
        toFirestore: (LevelInfo value, SetOptions? options) => value.toJson(),
      );
}

@Riverpod(keepAlive: true)
CollectionReference<PlayInfo> playInfoCollectionReference(
  PlayInfoCollectionReferenceRef ref,
) {
  final firestore = ref.watch(fireStoreProvider);

  return firestore.collection(FirestoreCollections.playInfo).withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) =>
            PlayInfo.fromJson(snapshot.data() ?? {}),
        toFirestore: (PlayInfo value, SetOptions? options) => value.toJson(),
      );
}

@Riverpod(keepAlive: true)
CollectionReference<Product> productCollectionReference(
  ProductCollectionReferenceRef ref,
) {
  final firestore = ref.watch(fireStoreProvider);

  return firestore.collection(FirestoreCollections.product).withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) =>
            Product.fromJson(snapshot.data() ?? {}),
        toFirestore: (Product value, SetOptions? options) => value.toJson(),
      );
}

@Riverpod(keepAlive: true)
CollectionReference<PurchaseHistory> purchaseHistoryCollectionReference(
  PurchaseHistoryCollectionReferenceRef ref,
) {
  final firestore = ref.watch(fireStoreProvider);

  return firestore
      .collection(FirestoreCollections.purchaseHistory)
      .withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) =>
            PurchaseHistory.fromJson(snapshot.data() ?? {}),
        toFirestore: (PurchaseHistory value, SetOptions? options) =>
            value.toJson(),
      );
}
