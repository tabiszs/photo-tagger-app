import 'package:flutter/material.dart';

class Routes {
  static const String firstPage = '/';
  static const String secondPage = '/second';
  static const String thirdPage = '/third';
}

class MyNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.firstPage: (BuildContext context) => FirstPage(),
        Routes.secondPage: (BuildContext context) => SecondPage(),
        Routes.thirdPage: (BuildContext context) => ThirdPage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: const Text(
          'First Page',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.secondPage);
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: const Text(
          'Second Page',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.thirdPage);
        },
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: const Text(
          'Third Page',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.popUntil(
              context, (r) => r.settings.name == Routes.firstPage);
        },
      ),
    );
  }
}
