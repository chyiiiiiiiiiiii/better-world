import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_sign_in_provider.g.dart';

const googleSignInScopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

@Riverpod(keepAlive: true)
GoogleSignIn googleSignIn(GoogleSignInRef ref) {
  return GoogleSignIn(
    scopes: googleSignInScopes,
  );
}
