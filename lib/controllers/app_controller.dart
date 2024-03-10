import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_controller.g.dart';

final darkModeProvider = StateProvider<bool>((ref) {
  return true;
});

@riverpod
class AppLocale extends _$AppLocale {
  SharedPreferences? _sharedPreferences;

  @override
  Future<Locale> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    final languageCode = _sharedPreferences?.getString('language_code') ?? 'en';

    return Locale(languageCode);
  }

  void changeLanguage(String languageCode) {
    update((previous) => Locale(languageCode));

    _sharedPreferences?.setString('language_code', languageCode);
  }
}
