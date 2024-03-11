import 'dart:async';
import 'dart:typed_data';

import 'package:envawareness/constants/constants.dart';
import 'package:envawareness/constants/environment_variables.dart';
import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/states/recycle_validator_state.dart';
import 'package:envawareness/utils/game_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'can_recycle_controller.g.dart';

@riverpod
class CanRecycleController extends _$CanRecycleController {
  final _generativeModel = GenerativeModel(
    model: Constants.generativeAiModel,
    apiKey: EnvironmentVariables.googleAiStudioApiKey,
  );

  @override
  FutureOr<RecycleValidatorState> build() async {
    return RecycleValidatorState();
  }

  Future<void> checkRecyclable(Uint8List bytes) async {
    await update((previous) => previous.copyWith(pickedImage: bytes));

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await getImage(bytes);

      return result;
    });
  }

  Future<RecycleValidatorState> getImage(Uint8List bytes) async {
    try {
      final appLocale = ref.read(appLocaleProvider).value;
      final languageCode = appLocale?.languageCode;

      final prompt = TextPart(
        '''
          Is this recyclable? Give me response in 30 words or less with some loverly description depend on language code I give.
          And also, return true and false in the beginning for telling me if it's recyclable or not.

          This is language code $languageCode.

          The response format is "<recyclable>#<response>".
        ''',
      );
      final imageParts = [
        DataPart('image/jpeg', bytes),
      ];
      final response = await _generativeModel.generateContent([
        Content.multi([
          prompt,
          ...imageParts,
        ]),
      ]);

      final responseText = (response.text ?? '').trim();
      debugPrint(responseText);

      final isRecyclable =
          bool.tryParse(responseText.split('#').firstOrNull ?? 'false') ??
              false;
      final currentLevel =
          ref.read(playControllerProvider).requireValue.playInfo.currentLevel;
      final addScore = calculateGamePerItemScore(
        currentLevel: currentLevel,
        numItems: 1,
        maxScoreProportionToTotalScore: isRecyclable ? 0.1 : 0.01,
      );

      final message = '''
            🤖: ${responseText.split('#').elementAtOrNull(1)}
          '''
          .trim();

      return state.requireValue.copyWith(
        aiResponse: message,
        addScore: addScore.toInt(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
