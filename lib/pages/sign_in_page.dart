import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:envawareness/zdogs/earth_zdog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart';
import 'package:zflutter/zflutter.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  static const routePath = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    ref.listen(showMessageProvider, (previous, next) async {
      if (next.isEmpty) {
        return;
      }

      await showMessageDialog<void>(
        context,
        message: next,
      );

      ref.invalidate(showMessageProvider);
    });

    final isLoading = ref.watch(authControllerProvider).isLoading;

    return Material(
      child: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ZIllustration(
                          children: [
                            const EarthZdog(rotateValue: ZVector.zero),
                            ZBoxToBoxAdapter(
                              width: 100,
                              height: 100,
                              depth: 20,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ).animate().moveY(
                            begin: -20,
                            end: 0,
                            duration: const Duration(milliseconds: 5000),
                          ),
                      Center(
                        child: Text(
                          'BETTER\n WORLD',
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: Durations.medium2,
                  child: Padding(
                    padding: const EdgeInsets.all(Spacings.px32),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              if (Platform.isIOS) ...[
                                AppTap(
                                  onTap: ref
                                      .read(authControllerProvider.notifier)
                                      .signInWithApple,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/apple.png',
                                        width: 32,
                                      ),
                                      Gaps.w20,
                                      Text(
                                        l10n.signInWithApple,
                                        style: context.textTheme.titleLarge,
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.h20,
                              ],
                              AppTap(
                                onTap: ref
                                    .read(authControllerProvider.notifier)
                                    .signInWithGoogle,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      width: 32,
                                    ),
                                    Gaps.w20,
                                    Text(
                                      l10n.signInWithGoogle,
                                      style: context.textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
