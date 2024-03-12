import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/providers/connectivity_provider.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityDetector extends ConsumerWidget {
  const ConnectivityDetector({
    required this.child,
    required this.onConnectivityChanged,
    super.key,
  });
  final Widget child;

  final ValueChanged<bool> onConnectivityChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Material(
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(Spacings.px20),
              child: ref
                  .watch(
                connectivityProvider,
              )
                  .when(
                data: (ConnectivityResult data) {
                  if (data
                      case ConnectivityResult.mobile ||
                          ConnectivityResult.wifi) {
                    onConnectivityChanged(true);

                    return const SizedBox.shrink();
                  }

                  onConnectivityChanged(false);

                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Center(
                      child: Text(
                        l10n.internetNotConnected,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  );
                },
                error: (Object error, StackTrace stackTrace) {
                  return const SizedBox.shrink();
                },
                loading: () {
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
