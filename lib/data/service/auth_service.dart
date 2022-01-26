import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

enum SignInResult {
  invalidCredentials,
  success,
}

class AuthService {
  const AuthService({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;
  static OAuthProvider provider = OAuthProvider("microsoft.com");

  bool get isSignedIn => _firebaseAuth.currentUser != null;
  Stream<bool> get isSignedInStream => _firebaseAuth.userChanges().map((user) => user != null);

  Future<SignInResult> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (isSignedIn) {
        await _firebaseAuth.signOut();
      }
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //await performLogin('microsoft.com', ['email'], {"locale": "pl"});
      return SignInResult.success;
    } on FirebaseAuthException catch (_) {
      return SignInResult.invalidCredentials;
    } catch (e) {
      rethrow;
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signOut() => _firebaseAuth.signOut();
}
