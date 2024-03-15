import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_controller.g.dart';

@riverpod
class DarkMode extends _$DarkMode {
  void toggleTheme() {
    state = !state;
  }

  @override
  bool build() {
    return true;
  }
}

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
