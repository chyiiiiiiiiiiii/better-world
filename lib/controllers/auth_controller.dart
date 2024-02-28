import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/sign_in_page.dart';
import 'package:envawareness/pages/welcome_page.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  User? build() {
    return ref.watch(authRepositoryProvider).currentUser;
  }

  Future<void> signIn() async {
    try {
      final authRepository = ref.watch(authRepositoryProvider);

      final googleAuth = await authRepository.signInGoogle();
      await authRepository.signInFirebase(authentication: googleAuth);

      state = authRepository.currentUser;

      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('firstTimeEnter') ?? true) {
        ref.read(appRouterProvider).go(WelcomePage.routePath);
        return;
      }

      ref.read(appRouterProvider).go(GamePage.routePath);
    } catch (error) {}
  }

  Future<void> signOut() async {
    await ref.watch(authRepositoryProvider).signOut();
    await ref.read(appRouterProvider).replace<void>(SignInPage.routePath);
  }
}
