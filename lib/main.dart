import 'dart:async';

import 'package:envawareness/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(() {
    runApp(const ProviderScope(child: App()));
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: $error');
  });
}
