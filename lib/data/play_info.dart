import 'package:envawareness/constants/endangered_specise_data.dart';
import 'package:envawareness/data/endangered_species_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_info.freezed.dart';
part 'play_info.g.dart';

@freezed
class PlayInfo with _$PlayInfo {
  factory PlayInfo({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'current_level') @Default(1) int currentLevel,
    @JsonKey(name: 'current_score') @Default(0) int currentScore,
    @JsonKey(name: 'total_score') @Default(0) int totalScore,
    @JsonKey(name: 'used_score') @Default(0) int usedScore,
    @JsonKey(name: 'per_click_score') @Default(1) int perClickScore,
    @JsonKey(name: 'is_game_completed') @Default(false) bool isGameCompleted,
    @JsonKey(name: 'animal_card_draw_count')
    @Default(0)
    int animalCardDrawCount,
    @JsonKey(name: 'owned_animal_cards')
    @Default([])
    List<int> ownedAnimalCardIndexes,
    @JsonKey(name: 'last_update_at') @Default(0) int lastUpdateAt,
  }) = _PlayInfo;

  factory PlayInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayInfoFromJson(json);
}

extension PlayInfoExtension on PlayInfo {
  int get availableScore => totalScore - usedScore;

  List<EndangeredSpeciesInfo> get ownedAnimalCardsData => ownedAnimalCardIndexes
      .map((index) => endangeredSpecies.elementAt(index))
      .toList();

  int get animalCardPrice => (1 + animalCardDrawCount) * 300;
}
