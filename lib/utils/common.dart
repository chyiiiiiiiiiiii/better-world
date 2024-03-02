import 'dart:io';
import 'dart:ui';

Locale get platformLocale =>
    Locale(Platform.localeName.split('_').firstOrNull ?? 'en');
