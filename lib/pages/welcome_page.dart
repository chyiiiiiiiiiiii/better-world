import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:envawareness/pages/game_page.dart';
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
  Widget build(BuildContext context) {
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
            label:
                '''歡迎，勇敢的探險家。你來到了一個瀕臨崩潰的世界，一個急需變革與希望的地方。在這裡，每一次點擊都不僅僅是觸碰屏幕那麼簡單；它是力量的象徵，是對未來的投資。你的使命，是利用這份力量來點亮太陽能和風力發電，帶領這個世界進入一個更加綠色、可持續的未來''',
          ),
          _SubPage(
            zdogWidget: const ZPositioned(
              translate: ZVector.only(x: 100, y: 60),
              child: DashZdog(),
            ),
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            label:
                '''但記住，這場旅程不止於此。隨著你的進步，你將有機會拯救那些瀕臨絕種的珍貴生命，從珊瑚礁中的彩色魚群到遠古森林的隱秘野生動物。每一個被救援的生命，都是對這個星球的一份愛與承諾。''',
          ),
          _SubPage(
            zoom: 0.8,
            zdogWidget: const ZPositioned(
              translate: ZVector.only(y: -100),
              child: EarthZdog(
                rotateValue: ZVector.zero,
              ),
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setBool('firstTimeEnter', false);
              context.pushReplacement(GamePage.routePath);
            },
            isLast: true,
            label: '''
所以，準備好接受挑戰了嗎？讓我們一起踏上這場既是遊戲又是使命的冒險之旅，為了地球，為了我們共同的家園。
''',
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
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (zdogWidget != null)
            SizedBox(
              width: 100,
              height: 20,
              child: ZIllustration(
                zoom: zoom,
                children: [zdogWidget!],
              ),
            ),
          AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                label,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
              text: '我準備好了',
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ).animate().scale(delay: const Duration(seconds: 3))
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
    );
  }
}
