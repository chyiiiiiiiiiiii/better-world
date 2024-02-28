import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

Future<AppLocalizations> getL10n() async {
  return AppLocalizations.delegate
      .load(Locale(Intl.getCurrentLocale().split('_').first));
}
