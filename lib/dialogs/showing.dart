import 'package:envawareness/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<T?> showMessageDialog<T>(
  BuildContext context, {
  required String message,
  VoidCallback? onConfirm,
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
                  onPressed: () {
                    context.pop();
                    onConfirm?.call();
                  },
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
