import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/data/level_info.dart';
import 'package:envawareness/data/play_info.dart';
import 'package:envawareness/data/product.dart';
import 'package:envawareness/firebase/firestore_collections_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_repository.g.dart';

class GameRepository {
  GameRepository({
    required this.levelCollectionReference,
    required this.playInfoCollectionReference,
    required this.productsCollectionReference,
  });

  final CollectionReference<LevelInfo> levelCollectionReference;
  final CollectionReference<PlayInfo> playInfoCollectionReference;
  final CollectionReference<Product> productsCollectionReference;

  Future<PlayInfo?> getPlayInfo({required String userId}) async {
    final query = playInfoCollectionReference.doc(userId);
    final snapshot = await query.get();
    final data = snapshot.data();

    return data;
  }

  Future<PlayInfo> addPlayInfo({required String userId}) async {
    final playInfo = PlayInfo(userId: userId);

    await playInfoCollectionReference.doc(userId).set(playInfo);

    return playInfo;
  }

  Stream<DocumentSnapshot<PlayInfo>> listenUser({required String userId}) {
    final stream = playInfoCollectionReference.doc(userId).snapshots();

    return stream;
  }

  Future<void> updatePlayInfo({
    required PlayInfo playInfo,
  }) async {
    await playInfoCollectionReference.doc(playInfo.userId).set(
          playInfo.copyWith(
            lastUpdateAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  Future<LevelInfo?> getLevelInfo({required int level}) async {
    final query = levelCollectionReference.doc('level_$level');
    final snapshot = await query.get();
    final lastData = snapshot.data();

    return lastData;
  }

  Future<int> getLevelTotalCount() async {
    final query = levelCollectionReference.count();
    final snapshot = await query.get();
    final count = snapshot.count ?? 0;

    return count;
  }

  Future<List<Product>> getProducts() async {
    final query = productsCollectionReference;
    final snapshot = await query.get();
    final products = snapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();

    return products;
  }

  Future<List<PlayInfo>> getLeaderBoard() async {
    final snapshot = await playInfoCollectionReference.limit(50).get();
    final data = snapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList()
      ..sort(
        (a, b) => b.ownedAnimalCardsData.length
            .compareTo(a.ownedAnimalCardsData.length),
      );

    return data;
  }
}

@riverpod
GameRepository gameRepository(GameRepositoryRef ref) {
  return GameRepository(
    levelCollectionReference: ref.watch(levelCollectionReferenceProvider),
    playInfoCollectionReference: ref.watch(playInfoCollectionReferenceProvider),
    productsCollectionReference: ref.watch(productCollectionReferenceProvider),
  );
}
