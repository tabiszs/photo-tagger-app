import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/authenticate/auth_gate.dart';

class RootAppPage extends StatelessWidget {
  const RootAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.black),
          )),
      title: 'Biblioteka Zdjęć',
      home: const AuthGate(),
    );
  }
}
