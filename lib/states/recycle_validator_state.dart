import 'dart:typed_data';

import 'package:envawareness/utils/unit8_list_convertor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recycle_validator_state.freezed.dart';
part 'recycle_validator_state.g.dart';

@freezed
class RecycleValidatorState with _$RecycleValidatorState {
  factory RecycleValidatorState({
    @Uint8ListConverter() Uint8List? pickedImage,
    @Default('') String aiResponse,
    @Default(0) int addScore,
  }) = _RecycleValidatorState;

  factory RecycleValidatorState.fromJson(Map<String, dynamic> json) =>
      _$RecycleValidatorStateFromJson(json);
}
