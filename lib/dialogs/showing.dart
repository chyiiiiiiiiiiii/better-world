import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

Future<T?> showMessageDialog<T>(
  BuildContext context, {
  required String message,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      Future.delayed(const Duration(seconds: 5), () => context.pop());

      return ScaleTransition(
        scale: animation,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showChooseDialog(
  BuildContext context, {
  required String message,
  VoidCallback? onCancel,
  VoidCallback? onConfirm,
}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return ScaleTransition(
        scale: animation,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          context.pop();
                          onCancel?.call();
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          context.pop();
                          onConfirm?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<T?> showLevelUpDialog<T>(
  BuildContext context, {
  required String message,
  required String nextLevel,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return ScaleTransition(
        scale: animation,
        child: LevelUpDialog(
          nextLevel: message,
          message: nextLevel,
        ),
      );
    },
  );
}

class LevelUpDialog extends StatelessWidget {
  const LevelUpDialog({
    required this.message,
    required this.nextLevel,
    super.key,
  });
  final String nextLevel;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                LottieBuilder.asset(
                  'assets/animations/level_up.json',
                  width: 200,
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      nextLevel,
                      style: context.textTheme.headlineLarge,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              context.l10n.passCongratulationMessage(nextLevel),
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
