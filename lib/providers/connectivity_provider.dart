import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<ConnectivityResult> connectivity(ConnectivityRef ref) {
  final controller = StreamController<ConnectivityResult>();

  Connectivity().checkConnectivity().then(controller.add);
  Connectivity().onConnectivityChanged.listen(
        controller.add,
      );

  return controller.stream;
}
