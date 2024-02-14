import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityDetector extends StatelessWidget {
  const ConnectivityDetector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (
                BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                final result = snapshot.requireData;
                if (result
                    case ConnectivityResult.mobile || ConnectivityResult.wifi) {
                  return const SizedBox.shrink();
                }

                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4,
                    sigmaY: 4,
                  ),
                  child: const Center(
                    child: Text(
                      'No Internet Available',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
