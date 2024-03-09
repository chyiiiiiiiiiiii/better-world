import 'dart:ui';

import 'package:universal_io/io.dart';

Locale get platformLocale =>
    Locale(Platform.localeName.split('_').firstOrNull ?? 'en');

String get platformLocaleLanguageCode => platformLocale.languageCode;
