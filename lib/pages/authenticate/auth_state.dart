import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
  const AuthState();
}

class SignedInState extends AuthState {
  const SignedInState({required this.user});

  final User? user;
}

class SigningInState extends AuthState {
  const SigningInState();
}

class SigningOutState extends AuthState {
  const SigningOutState();
}

class SignedOutState extends AuthState {
  const SignedOutState({this.error});

  final String? error;
}
