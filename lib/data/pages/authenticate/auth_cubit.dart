import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_tagger/data/service/auth_service.dart';
import 'package:photo_tagger/data/service/firestore_service.dart';
import 'package:photo_tagger/data/service/storage_service.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/data/pages/authenticate/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authService,
    required this.storageService,
    required this.firestoreService,
  }) : super(const SignedOutState()) {
    _subscription = authService.isSignedInStream.listen((isSignedInEvent) {
      // TODO remove
      emit(isSignedInEvent
          ? SignedInState(
              user: authService.currentUser,
              addPhotosCubit: AddPhotosCubit(
                storage: storageService,
                firestore: firestoreService,
                email: authService.currentUser?.email,
              ),
            )
          : const SignedOutState());
      // emit(const SignedOutState());
    });
  }

  final StorageService storageService;
  final AuthService authService;
  final FirestoreService firestoreService;
  StreamSubscription? _subscription;
  List<String> cachedUrls = [];

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    emit(const SigningInState());
    await Future.delayed(const Duration(seconds: 1));
    bool result = false;

    final online = await _hasNetwork();
    if (online) {
      result = await _signIn(email, password);
    } else {
      emit(const SignedOutState(error: 'Internet jest niedostępny.'));
    }
    return result;
  }

  Future<void> signOut() async {
    await clearImageCache();
    await authService.signOut();
    emit(const SignedOutState());
  }

  Future<void> clearImageCache() async {
    for (int i = 0; i < cachedUrls.length; ++i) {
      await DefaultCacheManager().removeFile(cachedUrls[i]);
    }
  }

  void addCachedImage(String url) {
    cachedUrls.add(url);
  }

  Future<bool> _signIn(String email, String password) async {
    bool signInResult = false;

    try {
      final result = await authService.signInWithEmailAndPassword(email, password);
      switch (result) {
        case SignInResult.success:
          emit(SignedInState(
            user: authService.currentUser,
            addPhotosCubit: AddPhotosCubit(
              storage: storageService,
              firestore: firestoreService,
              email: authService.currentUser?.email,
            ),
          ));
          signInResult = true;
          break;
        case SignInResult.invalidCredentials:
          emit(const SignedOutState(error: 'Nieprawidłowe dane.'));
          break;
      }
    } catch (_) {
      emit(const SignedOutState(error: 'Nieznany błąd.'));
    }
    return signInResult;
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
