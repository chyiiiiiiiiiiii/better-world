import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/controllers/firestore_provider.dart';
import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_collections_provider.g.dart';

@riverpod
CollectionReference<LevelInfo> levelCollectionReference(
  LevelCollectionReferenceRef ref,
) {
  final firestore = ref.watch(fireStoreProvider);

  return firestore.collection('levels').withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) =>
            LevelInfo.fromJson(snapshot.data() ?? {}),
        toFirestore: (LevelInfo value, SetOptions? options) => value.toJson(),
      );
}

@riverpod
CollectionReference<PlayInfo> userCollectionReference(
  UserCollectionReferenceRef ref,
) {
  final firestore = ref.watch(fireStoreProvider);

  return firestore.collection('users').withConverter(
        fromFirestore: (
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options,
        ) =>
            PlayInfo.fromJson(snapshot.data() ?? {}),
        toFirestore: (PlayInfo value, SetOptions? options) => value.toJson(),
      );
}
