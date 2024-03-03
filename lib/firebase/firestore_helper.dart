// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envawareness/constants/constants.dart';
import 'package:envawareness/constants/firestore_collections.dart';
import 'package:envawareness/data/level_info.dart';

/// n = Initial position, usually starting from 1
/// p0 = Initial value
/// r = Growth rate
/// a = Parameter controlling the growth upper limit
///
/// A "bounded exponential growth model" is used to calculate the experience points required to reach each level.
/// This model will gradually slow down the growth rate as the level increases, avoiding the unlimited growth of experience value requirements.
double boundedExponentialGrowth({
  required int n,
  required double p0,
  double r = 1.1,
  double a = 0.005,
}) {
  if (n == 1) {
    return p0;
  }

  return p0 * pow(r, n - 1) / (1 + a * pow(r, n - 1));
}

Future<void> addLevelsToFirestore() async {
  const beginValue = Constants.beginLevelPassScore;

  for (var n = 1; n <= Constants.appTotalLevels; n++) {
    final points = n == 1
        ? beginValue
        : boundedExponentialGrowth(
            n: n,
            p0: beginValue.toDouble(),
          );

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
