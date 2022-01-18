import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/auth_service.dart';
import 'package:photo_tagger/data/firestore_service.dart';
import 'package:photo_tagger/data/storage_service.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_gate.dart';
import 'package:provider/provider.dart';

class PhotoTaggerApp extends StatelessWidget {
  const PhotoTaggerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthService(firebaseAuth: FirebaseAuth.instance)),
        Provider(create: (_) => StorageService(storage: FirebaseStorage.instance)),
        Provider(create: (_) => FirestoreService(firestore: FirebaseFirestore.instance))
      ],
      child: BlocProvider(
        create: (ctx) => AuthCubit(
          authService: ctx.read<AuthService>(),
          storageService: ctx.read<StorageService>(),
          firestoreService: ctx.read<FirestoreService>(),
        ),
        child: const AuthGate(),
      ),
    );
  }
}
