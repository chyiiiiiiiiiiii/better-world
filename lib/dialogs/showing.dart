import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/can_recycle_page.dart';
import 'package:envawareness/pages/catch_game_page.dart';
import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

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

Future<T?> showGamesDialog<T>(
  BuildContext context, {
  VoidCallback? onConfirm,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return GameDialog(
        animation: animation,
      );
    },
  );
}

class GameDialog extends StatelessWidget {
  const GameDialog({
    required this.animation,
    super.key,
  });
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ScaleTransition(
      scale: animation,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    GameDialogItem(
                      imagePath: 'assets/images/game_icon/catch_game.png',
                      title: l10n.game_catch_the_trash,
                      onTap: () {
                        context
                          ..pop()
                          ..push(CatchGamePage.routePath);
                      },
                    ),
                    GameDialogItem(
                      imagePath: 'assets/images/game_icon/recycle_game.png',
                      title: l10n.game_recycle_card,
                      onTap: () {
                        context
                          ..pop()
                          ..push(RecycleGamePage.routePath);
                      },
                    ),
                    GameDialogItem(
                      title: l10n.game_scan_trash,
                      onTap: () {
                        context
                          ..pop()
                          ..push(GeminiImagePage.canRecycleRoutePath);
                      },
                      imagePath: 'assets/images/game_icon/scan_recycle.png',
                    ),
                    GameDialogItem(
                      title: l10n.game_scan_electron,
                      onTap: () {
                        context
                          ..pop()
                          ..push(GeminiImagePage.electronRoutePath);
                      },
                      imagePath: 'assets/images/game_icon/scan_electron.png',
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameDialogItem extends StatelessWidget {
  const GameDialogItem({
    required this.onTap,
    required this.imagePath,
    required this.title,
    super.key,
  });

  final VoidCallback onTap;
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppTap(
      onTap: onTap.call,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 64,
          ),
          Gaps.h12,
          Text(
            title,
            style: context.textTheme.headlineSmall?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
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
          child: SizedBox(
            width: 300,
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
                  Gaps.h12,
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
        ),
      );
    },
  );
}

Future<T?> showLevelUpDialog<T>(
  BuildContext context, {
  required String message,
  required String nextLevel,
  required String tipText,
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
          nextLevel: nextLevel,
          message: message,
          tipText: tipText,
        ),
      );
    },
  );
}

class LevelUpDialog extends StatelessWidget {
  const LevelUpDialog({
    required this.message,
    required this.nextLevel,
    required this.tipText,
    super.key,
  });
  final String message;
  final String nextLevel;
  final String tipText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      child: SizedBox(
        width: 300,
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
              Gaps.h12,
              Text(
                message,
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              Gaps.h12,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.background.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/light_bulb.png',
                      width: 24,
                      height: 24,
                    ),
                    Gaps.w12,
                    Expanded(
                      child: Text(
                        '${l10n.tip}: $tipText',
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.h12,
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
  }
}
