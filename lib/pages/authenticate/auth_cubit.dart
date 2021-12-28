import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/auth_service.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authService})
      : super(authService.isSignedIn
            ? const SignedInState()
            : const SignedOutState()) {
    _subscription = authService.isSignedInStream.listen((isSignedInEvent) {
      emit(isSignedInEvent ? const SignedInState() : const SignedOutState());
    });
  }

  final AuthService authService;
  StreamSubscription? _subscription;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(const SigningInState());
    await Future.delayed(const Duration(seconds: 1));

    try {
      final result =
          await authService.signInWithEmailAndPassword(email, password);

      switch (result) {
        case SignInResult.success:
          emit(const SignedInState());
          break;
        case SignInResult.invalidCredentials:
          emit(const SignedOutState(error: 'Nieprawidłowe dane.'));
          break;
      }
    } catch (_) {
      emit(const SignedOutState(error: 'Nieznany błąd.'));
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    emit(const SignedOutState());
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
