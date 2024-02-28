import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/providers/show_message_provider.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  static const routePath = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final screenWidth = MediaQuery.sizeOf(context).width;

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

    return Material(
      child: AppTap(
        onTap: ref.read(authControllerProvider.notifier).signIn,
        child: Center(
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    width: screenWidth * 0.1,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    l10n.signInWithGoogle,
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
