import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routePath = '/splash';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 400), () async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('firstTimeEnter') ?? true) {
        context.pushReplacement(WelcomePage.routePath);
        return;
      }

      context.pushReplacement(GamePage.routePath);
    });

    return const Material(child: FlutterLogo());
  }
}
