import 'dart:ui';

extension LocaleExtension on Locale {
  bool get isEnglish => languageCode == 'en';
  bool get isJapanese => languageCode == 'ja';
  bool get isChinese => languageCode == 'zh';
}
