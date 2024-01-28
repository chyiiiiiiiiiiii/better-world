import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: SplashPage.routePath,
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [],
  routes: [
    GoRoute(
      path: SplashPage.routePath,
      name: 'splash',
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: GamePage.routePath,
      name: 'game',
      builder: (context, state) {
        return const GamePage();
      },
    ),
  ],
);
