import 'dart:math';

import 'package:envawareness/utils/spacings.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

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

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  double get paddingTop => viewPadding.top;
  double get paddingBottom => viewPadding.bottom;
  double get safePaddingBottom => _safeVerticalPadding();

  double _safeVerticalPadding() {
    final safeAreaBottom = viewPadding.bottom;
    if (Platform.isAndroid) {
      return max(safeAreaBottom, Spacings.px12);
    }

    if (safeAreaBottom == 0) {
      return Spacings.px12;
    }

    return safeAreaBottom;
  }
}
