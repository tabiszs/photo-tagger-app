import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class SignedInState extends AuthState {
  const SignedInState({
    required this.user,
    required this.addPhotosCubit,
  });

  final User? user;
  final AddPhotosCubit addPhotosCubit;
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
