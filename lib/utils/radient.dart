import 'dart:math';

extension RadientNum on num {
  double toDegrees() {
    return this * (180 / pi);
  }

  double toRadians() {
    return this * (pi / 180);
  }
}
