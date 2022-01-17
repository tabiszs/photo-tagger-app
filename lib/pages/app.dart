import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/auth_service.dart';

import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_gate.dart';

import 'package:provider/provider.dart';

class PhotoTaggerApp extends StatelessWidget {
  const PhotoTaggerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthService(firebaseAuth: FirebaseAuth.instance),
      child: BlocProvider(
        create: (ctx) => AuthCubit(authService: ctx.read()),
        child: const AuthGate(),
      ),
    );
  }
}
