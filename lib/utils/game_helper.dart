// ignore_for_file: lines_longer_than_80_chars

import 'package:envawareness/constants/constants.dart';
import 'package:envawareness/firebase/firestore_helper.dart';

/// 計算遊戲內每個物品的經驗值
///
/// [currentLevel] -> current level of user
/// [numItems] -> item amount of the game
/// [maxScoreProportionToTotalScore] Max score (item score sum) proportion to total score of current level
/// [beginLevelPassScore] -> Score of beginning level
int calculateGamePerItemScore({
  required int currentLevel,
  required int numItems,
  required double maxScoreProportionToTotalScore,
  int beginLevelPassScore = Constants.beginLevelPassScore,
}) {
  final totalExperience = boundedExponentialGrowth(
    n: currentLevel,
    p0: beginLevelPassScore.toDouble(),
  );

  return totalExperience ~/ (numItems * (1 / maxScoreProportionToTotalScore));
}
