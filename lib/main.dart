import 'dart:async';

import 'package:envawareness/app.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() {
    runApp(const App());
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: $error');
  });
}
