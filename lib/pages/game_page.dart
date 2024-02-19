import 'package:envawareness/features/menu/menu_widget.dart';
import 'package:envawareness/features/particle/particle.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/features/play/play_view.dart';
import 'package:envawareness/features/store/store_view.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/spacings.dart';
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
    required WidgetRef ref,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(showMessageProvider, (previous, next) async {
      if (next.isEmpty) {
        return;
      }

      await _showMessage(
        context: context,
        message: next,
        ref: ref,
      );

      ref.invalidate(showMessageProvider);
    });

    final isEarthBlock = ref.watch(isEarthBlockProvider);
    final validPurchases = ref.watch(
      playControllerProvider.select(
        (value) => value.value?.validPurchases ?? [],
      ),
    );

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ref.watch(playControllerProvider).when(
          data: (gameState) {
            return Stack(
              alignment: Alignment.center,
              children: [
                const ParticleArea(),
                const EarthZdog(),
                if (!isEarthBlock) const PlayView(),
                const DashZdog(),
                if (isEarthBlock)
                  const Positioned.fill(
                    top: 100,
                    child: StoreView(),
                  ),
                // const TrashMonster(),
                const Positioned(
                  bottom: Spacings.px8,
                  child: MenuWidget(),
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
