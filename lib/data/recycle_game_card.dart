import 'package:freezed_annotation/freezed_annotation.dart';

part 'recycle_game_card.freezed.dart';
part 'recycle_game_card.g.dart';

@freezed
class RecycleGameCard with _$RecycleGameCard {
  factory RecycleGameCard({
    @Default('') String name,
    @Default('') @JsonKey(name: 'name_en') String nameEn,
    @Default('') @JsonKey(name: 'name_jp') String nameJp,
    @Default(0) int value,
    @Default('') @JsonKey(name: 'image_url') String imageUrl,
  }) = _RecycleGameCard;

  factory RecycleGameCard.fromJson(Map<String, dynamic> json) =>
      _$RecycleGameCardFromJson(json);
}
