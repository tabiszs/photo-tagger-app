import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/app.dart';
import 'package:photo_tagger/pages/initialize_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const _App(app: PhotoTaggerApp()));
}

class _App extends StatefulWidget {
  const _App({
    Key? key,
    required this.app,
  }) : super(key: key);

  final Widget app;

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static const Duration splashScreenDuration = Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeFirebaseApp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return widget.app;
            default:
              return const InitializePage(splashScreenDuration: splashScreenDuration);
          }
        });
  }

  Future<FirebaseApp> initializeFirebaseApp() async {
    await Future.delayed(splashScreenDuration);
    return _initialization;
  }
}
