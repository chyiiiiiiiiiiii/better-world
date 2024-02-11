import 'package:cached_network_image/cached_network_image.dart';
import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/controllers/game_controller.dart';
import 'package:envawareness/providers/show_message_provider.dart';
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
    final screenWidth = MediaQuery.sizeOf(context).width;

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

    final username = ref.watch(
      authControllerProvider.select((state) => state?.displayName ?? ''),
    );

    return Material(
      child: Center(
        child: ref.watch(gameControllerProvider).when(
          data: (gameState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hi, $username',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Level: ${gameState.levelInfo.level}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Pass Score: ${gameState.levelInfo.passScore}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Opacity(
                  opacity: gameState.finishProgress,
                  child: GestureDetector(
                    onTap: () => ref
                        .read(gameControllerProvider.notifier)
                        .updateMyScore(),
                    child: CachedNetworkImage(
                      imageUrl: gameState.levelInfo.earthImageUrl,
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'My Score: ${gameState.playInfo.currentScore}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).signOut(),
                  child: const Text('Sign Out'),
                ),
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
