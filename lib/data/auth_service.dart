import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // https://pub.dev/packages/firebase_auth_oauth/example
  Future<void> performLogin(
      String provider, List<String> scopes, Map<String, String> parameters) async {
    try {
      await FirebaseAuthOAuth().openSignInFlow(provider, scopes, parameters);
    } on PlatformException catch (error) {
      /**
       * The plugin has the following error codes:
       * 1. FirebaseAuthError: FirebaseAuth related error
       * 2. PlatformError: An platform related error
       * 3. PluginError: An error from this plugin
       */
      debugPrint("${error.code}: ${error.message}");
      rethrow;
    }
  }

  Future<void> performLink(
      String provider, List<String> scopes, Map<String, String> parameters) async {
    try {
      await FirebaseAuthOAuth().linkExistingUserWithCredentials(provider, scopes, parameters);
    } on PlatformException catch (error) {
      /**
       * The plugin has the following error codes:
       * 1. FirebaseAuthError: FirebaseAuth related error
       * 2. PlatformError: An platform related error
       * 3. PluginError: An error from this plugin
       */
      debugPrint("${error.code}: ${error.message}");
      rethrow;
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signOut() => _firebaseAuth.signOut();
}
