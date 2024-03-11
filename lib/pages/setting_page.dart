import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/controllers/auth_controller.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/extensions/locale_extension.dart';
import 'package:envawareness/features/play/play_view.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/welcome_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  static const routePath = '/setting';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final appLocale = ref.watch(appLocaleProvider).value;
    final user = ref
        .watch(
          authControllerProvider,
        )
        .value;
    final username = user?.displayName ?? '';
    final photoURL = user?.photoURL ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacings.px20),
          child: Column(
            children: [
              Row(
                children: [
                  AppAvatar(
                    imageUrl: photoURL,
                  ),
                  Gaps.w12,
                  Expanded(
                    child: Text(
                      username,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  Gaps.w12,
                  TextButton(
                    onPressed: () {
                      showChooseDialog(
                        context,
                        message: l10n.signOutTitle,
                        onConfirm: () =>
                            ref.read(authControllerProvider.notifier).signOut(),
                      );
                    },
                    child: Text(
                      l10n.settingSignOut,
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Gaps.h12,
              Divider(
                color: Colors.grey.shade300,
                thickness: 0.5,
              ),
              Gaps.h12,
              Column(
                children: [
                  Text(
                    l10n.settingDisplayLanguage,
                    style: context.textTheme.titleMedium,
                  ),
                  Gaps.h16,
                  Wrap(
                    spacing: Spacings.px12,
                    runSpacing: Spacings.px8,
                    runAlignment: WrapAlignment.center,
                    children: [
                      _LanguageButton(
                        text: l10n.languageEn,
                        isSelected: appLocale?.isEnglish,
                        onTap: () => ref
                            .read(appLocaleProvider.notifier)
                            .changeLanguage('en'),
                      ),
                      _LanguageButton(
                        text: l10n.languageJa,
                        isSelected: appLocale?.isJapanese,
                        onTap: () => ref
                            .read(appLocaleProvider.notifier)
                            .changeLanguage('ja'),
                      ),
                      _LanguageButton(
                        text: l10n.languageZh,
                        isSelected: appLocale?.isChinese,
                        onTap: () => ref
                            .read(appLocaleProvider.notifier)
                            .changeLanguage('zh'),
                      ),
                    ],
                  ),
                ],
              ),
              if (kDebugMode)
                AppTap(
                  onTap: () {
                    context.pushReplacement(WelcomePage.routePath);
                  },
                  child: const Text('WelComePage'),
                ),
              const Spacer(),
              Center(
                child: DefaultButton(
                  onPressed: context.pop,
                  text: l10n.close,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.text,
    required this.onTap,
    this.isSelected,
    super.key,
  });

  final String text;
  final bool? isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          context.colorScheme.secondary
              .withOpacity((isSelected ?? false) ? 1 : 0.5),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
