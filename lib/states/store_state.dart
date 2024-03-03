import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_state.freezed.dart';
part 'store_state.g.dart';

@freezed
class StoreState with _$StoreState {
  factory StoreState({
    required int animalCardPrice,
  }) = _StoreState;

  factory StoreState.fromJson(Map<String, dynamic> json) =>
      _$StoreStateFromJson(json);
}
