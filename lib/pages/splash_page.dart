import 'package:envawareness/pages/game_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routePath = '/splash';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.pushReplacement(GamePage.routePath);
    });

    return const Material(child: FlutterLogo());
  }
}
