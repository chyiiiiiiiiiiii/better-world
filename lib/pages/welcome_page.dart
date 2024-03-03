import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/radient.dart';
import 'package:envawareness/zdogs/dash_zdog.dart';
import 'package:envawareness/zdogs/game_zdog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zflutter/zflutter.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});
  static const routePath = '/welcome';

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _SubPage(
            zdogWidget: ZGroup(
              children: [
                TriangleTreeZdog(
                  translate: const ZVector.only(x: -10, y: -40),
                  rotate: ZVector.only(x: 90.0.toRadius()),
                ),
                CircleTreeZdog(
                  translate: const ZVector.only(x: 10, y: -40),
                  rotate: ZVector.only(x: 90.0.toRadius()),
                ),
              ],
            ),
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            label: l10n.welcomeMessage,
          ),
          _SubPage(
            zdogWidget: const ZPositioned(
              translate: ZVector.only(x: 100, y: 60),
              child: DashZdog(),
            ),
            label: l10n.welcomeMessage2,
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
          ),
          _SubPage(
            zoom: 0.8,
            zdogWidget: const ZPositioned(
              translate: ZVector.only(y: -100),
              child: EarthZdog(
                rotateValue: ZVector.zero,
              ),
            ),
            isLast: true,
            label: l10n.welcomeMessage3,
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();

              await pref.setBool('firstTimeEnter', false);

              if (!context.mounted) {
                return;
              }

              context.pushReplacement(GamePage.routePath);
            },
          ),
        ],
      ),
    );
  }
}

class _SubPage extends StatelessWidget {
  const _SubPage({
    required this.onPressed,
    required this.label,
    this.zoom = 1,
    this.zdogWidget,
    this.isLast = false,
  });
  final VoidCallback onPressed;
  final String label;
  final bool isLast;
  final double zoom;
  final Widget? zdogWidget;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: onPressed.call,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (zdogWidget case final zdogWidget?)
              SizedBox(
                width: 100,
                height: 20,
                child: ZIllustration(
                  zoom: zoom,
                  children: [zdogWidget],
                ),
              ),
            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  label,
                  textAlign: TextAlign.center,
                  textStyle: context.textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                  ),
                  speed: const Duration(milliseconds: 50),
                ),
              ],
            ),
            Gaps.h32,
            if (isLast)
              DefaultButton(
                onPressed: onPressed,
                text: l10n.welcomeConfirm,
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ).animate().scale(
                    delay: const Duration(seconds: 3),
                    duration: Durations.short2,
                  )
            else
              IconButton(
                onPressed: onPressed,
                iconSize: 40,
                icon: const Icon(Icons.arrow_drop_down_rounded),
              )
                  .animate(
                    onPlay: (controller) =>
                        controller.repeat(reverse: true), // loop
                  )
                  .fade(
                    begin: 0.3,
                    duration: const Duration(
                      seconds: 1,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
