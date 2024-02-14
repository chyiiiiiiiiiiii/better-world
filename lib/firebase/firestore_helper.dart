import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/constants/firestore_collections.dart';
import 'package:envawareness/data/level_info.dart';

double _boundedExponentialGrowth(int n, double p0, double r, double a) {
  if (n == 1) {
    return p0;
  }
  return p0 * pow(r, n - 1) / (1 + a * pow(r, n - 1));
}

Future<void> addLevelsToFirestore() async {
  const p0 = 1000.0; // 起始
  const r = 1.1; // 成長率
  const a = 0.005; // 控制成長上限的参数

  for (var n = 1; n <= 200; n++) {
    final points = n == 1 ? 100 : _boundedExponentialGrowth(n, p0, r, a);
    await FirebaseFirestore.instance
        .collection(FirestoreCollections.level)
        .withConverter(
          fromFirestore: (
            DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? options,
          ) =>
              LevelInfo.fromJson(snapshot.data() ?? {}),
          toFirestore: (LevelInfo value, SetOptions? options) => value.toJson(),
        )
        .doc('level_$n')
        .set(
          LevelInfo(
            level: n,
            passScore: points.toInt(),
          ),
        );
  }
}
