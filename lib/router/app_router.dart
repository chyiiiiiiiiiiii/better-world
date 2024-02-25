import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/pages/sign_in_page.dart';
import 'package:envawareness/pages/splash_page.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/router/router_refresh_stream.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: SplashPage.routePath,
    navigatorKey: navigatorKey,
    observers: [],
    redirect: (context, state) async {
      final isAuthenticated = await authRepository.isAuthenticated();
      if (!isAuthenticated) {
        return SignInPage.routePath;
      }

      return null;
    },
    refreshListenable: RouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: SplashPage.routePath,
        name: 'splash',
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: SignInPage.routePath,
        name: 'sign-in',
        builder: (context, state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: GamePage.routePath,
        name: 'game',
        builder: (context, state) {
          return  GamePage();
        },
      ),
      GoRoute(
        path: RecycleGamePage.routePath,
        name: 'recycle-game',
        builder: (context, state) {
          return const RecycleGamePage();
        },
      ),
    ],
  );
}
