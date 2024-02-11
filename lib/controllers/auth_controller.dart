import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/sign_in_page.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  User? build() {
    return null;
  }

  Future<void> signIn() async {
    final authRepository = ref.watch(authRepositoryProvider);

    final googleAuth = await authRepository.signInGoogle();
    await authRepository.signInFirebase(authentication: googleAuth);

    state = authRepository.currentUser;

    ref.read(appRouterProvider).go(GamePage.routePath);
  }

  Future<void> signOut() async {
    await ref.watch(authRepositoryProvider).signOut();
    ref.read(appRouterProvider).go(SignInPage.routePath);
  }
}
