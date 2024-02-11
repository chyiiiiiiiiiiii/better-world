import 'dart:async';

import 'package:envawareness/app.dart';
import 'package:envawareness/app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

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
