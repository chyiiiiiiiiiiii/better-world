import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get height => screenSize.height;
  double get width => screenSize.width;

  Brightness get brightness => MediaQuery.platformBrightnessOf(this);
  bool get isLight => brightness == Brightness.light;
  bool get isDark => brightness == Brightness.dark;

  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}
