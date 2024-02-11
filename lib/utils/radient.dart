import 'dart:math';

extension RadiusNum on num {
  double toDegrees() {
    return this * (180 / pi);
  }

  double toRadius() {
    return this * (pi / 180);
  }
}
