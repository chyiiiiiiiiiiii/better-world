import 'package:envawareness/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

Future<AppLocalizations> getL10n() async {
  return AppLocalizations.delegate.load(platformLocale);
}
