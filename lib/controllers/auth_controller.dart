import 'package:envawareness/pages/game_page.dart';
import 'package:envawareness/pages/sign_in_page.dart';
import 'package:envawareness/pages/welcome_page.dart';
import 'package:envawareness/repositories/auth_repository.dart';
import 'package:envawareness/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<User?> build() {
    return ref.watch(authRepositoryProvider).currentUser;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    try {
      final authRepository = ref.read(authRepositoryProvider);

      final googleAccount = await authRepository.signInGoogle();
      final authentication = await googleAccount?.authentication;
      if (authentication == null) {
        throw Exception('Sign in failed.');
      }

      final email = googleAccount?.email ?? '';
      final name = googleAccount?.displayName ?? '';
      final photoUrl = googleAccount?.photoUrl ?? '';

      final oAuthCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      await authRepository.signInFirebase(
        oAuthCredential: oAuthCredential,
      );

      final user = authRepository.currentUser;
      await user?.updateDisplayName(name.isEmpty ? email : name);
      await user?.updatePhotoURL(photoUrl);

      state = AsyncValue.data(user);

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('isSignedIn', true);

      if (sharedPreferences.getBool('firstTimeEnter') ?? true) {
        ref.read(appRouterProvider).go(WelcomePage.routePath);
        return;
      }

      ref.read(appRouterProvider).go(GamePage.routePath);
    } catch (error, st) {
      state = AsyncValue.error(error, st);
    }
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();

    try {
      final authRepository = ref.read(authRepositoryProvider);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final email = appleCredential.email ?? '';
      final name = appleCredential.givenName ?? '';

      final oAuthProvider = OAuthProvider('apple.com');
      final oAuthCredential = oAuthProvider.credential(
        idToken: appleCredential.identityToken ?? '',
        accessToken: appleCredential.authorizationCode,
      );

      await authRepository.signInFirebase(
        oAuthCredential: oAuthCredential,
      );

      final user = authRepository.currentUser;
      await user?.updateDisplayName(name.isEmpty ? email : name);

      state = AsyncValue.data(user);

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('isSignedIn', true);

      if (sharedPreferences.getBool('firstTimeEnter') ?? true) {
        ref.read(appRouterProvider).go(WelcomePage.routePath);
        return;
      }

      ref.read(appRouterProvider).go(GamePage.routePath);
    } catch (error, st) {
      state = AsyncValue.error(error, st);
    }
  }

  Future<void> signOut() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isSignedIn', false);

    await ref.watch(authRepositoryProvider).signOut();
    await ref.read(appRouterProvider).replace<void>(SignInPage.routePath);
  }
}
