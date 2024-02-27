import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'can_recycle_controller.g.dart';

@riverpod
class CanRecycleController extends _$CanRecycleController {
  Future<void> canRecycleThis(Uint8List bytes) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await getImage(bytes);
      return result;
    });
  }

  Future<String> getImage(Uint8List bytes) async {
    final gemini = Gemini.instance;
    try {
      final result = await gemini.textAndImage(
        text: 'Is this recyclable? response in 25 words or less',

        /// text
        images: [bytes],

        /// list of images
      );
      return result?.content?.parts?.last.text ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  FutureOr<String> build() async {
    return '';
  }
}
