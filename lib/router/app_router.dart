import 'package:envawareness/pages/can_recycle_page.dart';
import 'package:envawareness/pages/catch_game_page.dart';
import 'package:envawareness/pages/endangered_species_cards_page.dart';
import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/recycle_game_page.dart';
import 'package:envawareness/pages/setting_page.dart';
import 'package:envawareness/pages/sign_in_page.dart';
import 'package:envawareness/pages/splash_page.dart';
import 'package:envawareness/pages/welcome_page.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/router/router_refresh_stream.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: GamePage.routePath,
    navigatorKey: navigatorKey,
    observers: [],
    redirect: (context, state) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final isSignedIn = sharedPreferences.getBool('isSignedIn') ?? false;
      if (!isSignedIn) {
        return SignInPage.routePath;
      }

      // final isAuthenticated = await authRepository.isAuthenticated();
      // if (!isAuthenticated) {
      //   return SignInPage.routePath;
      // }

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
        path: WelcomePage.routePath,
        name: 'welcome',
        builder: (context, state) {
          return const WelcomePage();
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
          return const GamePage();
        },
      ),
      GoRoute(
        path: RecycleGamePage.routePath,
        name: 'recycle-game',
        builder: (context, state) {
          return const RecycleGamePage();
        },
      ),
      GoRoute(
        path: EndangeredSpeciesCardsPage.routePath,
        name: 'endangered-species-cards',
        builder: (context, state) {
          return const EndangeredSpeciesCardsPage();
        },
      ),
      GoRoute(
        path: CatchGamePage.routePath,
        name: 'catch-game',
        builder: (context, state) {
          return const CatchGamePage();
        },
      ),
      GoRoute(
        path: GeminiImagePage.canRecycleRoutePath,
        name: 'can-recycle',
        builder: (context, state) {
          return const GeminiImagePage(
            isElectron: false,
          );
        },
      ),
      GoRoute(
        path: GeminiImagePage.electronRoutePath,
        name: 'electron-recycle',
        builder: (context, state) {
          return const GeminiImagePage(
            isElectron: true,
          );
        },
      ),
      GoRoute(
        path: SettingPage.routePath,
        name: 'setting',
        builder: (context, state) {
          return const SettingPage();
        },
      ),
    ],
  );
}
