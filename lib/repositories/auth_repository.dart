import 'package:envawareness/firebase/firebase_auth_provider.dart';
import 'package:envawareness/providers/google_sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  User? get currentUser => firebaseAuth.currentUser;
  String get userId => currentUser?.uid ?? '';
  Future<bool> isAuthenticated() async {
    final user = firebaseAuth.currentUser;

    return switch (user) {
      final User _ when kIsWeb =>
        await googleSignIn.canAccessScopes(googleSignInScopes),
      final User _ => true,
      _ => false
    };
  }

  Future<GoogleSignInAccount?> signInGoogle() async {
    final googleAccount = await googleSignIn.signIn();

    return googleAccount;
  }

  Future<void> signInFirebase({
    required GoogleSignInAuthentication authentication,
  }) async {
    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
    await firebaseAuth.signInWithCredential(oAuthCredential);
  }

  Future<void> signOut() async {
    await Future.wait([
      googleSignIn.signOut(),
      googleSignIn.disconnect(),
      firebaseAuth.signOut(),
    ]);
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    googleSignIn: ref.watch(googleSignInProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider),
  );
}
