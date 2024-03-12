import 'dart:async';

import 'package:envawareness/app.dart';
import 'package:envawareness/app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    usePathUrlStrategy();

    runApp(
      ProviderScope(
        child: AppStartupWidget(
          onLoaded: (context) => const App(),
        ),
      ),
    );
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: $error');
  });
}
