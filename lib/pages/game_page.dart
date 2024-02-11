import 'package:envawareness/features/particle/particle.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/features/play/play_view.dart';
import 'package:envawareness/features/trash/trash_monster.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/zdogs/dash_zdog.dart';
import 'package:envawareness/zdogs/earth_zdog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  static const routePath = '/';

  Future<void> _showMessage({
    required BuildContext context,
    required String message,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          ScaleTransition(
        scale: animation,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.headlineSmall,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(showMessageProvider, (previous, next) async {
      if (next.isEmpty) {
        return;
      }

      await _showMessage(
        context: context,
        message: next,
      );

      ref.invalidate(showMessageProvider);
    });

    return Material(
      child: Center(
        child: ref.watch(playControllerProvider).when(
          data: (gameState) {
            return const Stack(
              children: [
                ParticleArea(),
                EarthZdog(),
                PlayView(),
                IgnorePointer(child: DashZdog()),
                TrashMonster(),
              ],
            );
          },
          loading: () {
            return const CircularProgressIndicator();
          },
          error: (error, stackTrace) {
            return Text(
              '$error',
            );
          },
        ),
      ),
    );
  }
}
