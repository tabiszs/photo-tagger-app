import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/auth_service.dart';
import 'package:photo_tagger/data/firestore_service.dart';
import 'package:photo_tagger/data/storage_service.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authService,
    required this.storageService,
    required this.firestoreService,
  }) : super(authService.isSignedIn
            ? SignedInState(
                user: authService.currentUser,
                addPhotosCubit: AddPhotosCubit(
                  storage: storageService,
                  firestore: firestoreService,
                ),
              )
            : const SignedOutState()) {
    _subscription = authService.isSignedInStream.listen((isSignedInEvent) {
      emit(isSignedInEvent
          ? SignedInState(
              user: authService.currentUser,
              addPhotosCubit: AddPhotosCubit(
                storage: storageService,
                firestore: firestoreService,
              ),
            )
          : const SignedOutState());
    });
  }

  final StorageService storageService;
  final AuthService authService;
  final FirestoreService firestoreService;
  StreamSubscription? _subscription;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(const SigningInState());
    await Future.delayed(const Duration(seconds: 1));

    final online = await _hasNetwork();
    if (online) {
      _signIn(email, password);
    } else {
      emit(const SignedOutState(error: 'Internet jest niedostępny.'));
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    emit(const SignedOutState());
  }

  void _signIn(String email, String password) async {
    try {
      final result = await authService.signInWithEmailAndPassword(email, password);
      switch (result) {
        case SignInResult.success:
          emit(SignedInState(
            user: authService.currentUser,
            addPhotosCubit: AddPhotosCubit(
              storage: storageService,
              firestore: firestoreService,
            ),
          ));
          break;
        case SignInResult.invalidCredentials:
          emit(const SignedOutState(error: 'Nieprawidłowe dane.'));
          break;
      }
    } catch (_) {
      emit(const SignedOutState(error: 'Nieznany błąd.'));
    }
  }

  // https://stackoverflow.com/questions/49648022/check-whether-there-is-an-internet-connection-available-on-flutter-app
  Future<bool> _hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
