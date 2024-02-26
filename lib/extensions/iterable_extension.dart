extension IterableExtension<T> on Iterable<T> {
  T firstOrElse(T Function() orElse) {
    return firstWhere((_) => true, orElse: orElse);
  }

  T? firstOrNull() {
    return firstOrElse(() => null as T);
  }

  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
