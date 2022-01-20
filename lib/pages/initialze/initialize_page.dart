import 'package:flutter/material.dart';

class InitializePage extends StatelessWidget {
  const InitializePage({required this.splashScreenDuration, Key? key}) : super(key: key);
  final Duration splashScreenDuration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitializeWidget(splashScreenDuration: splashScreenDuration),
    );
  }
}

class InitializeWidget extends StatelessWidget {
  const InitializeWidget({required this.splashScreenDuration, Key? key}) : super(key: key);
  final Duration splashScreenDuration;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: AnimatedOpacity(
          opacity: 1,
          duration: splashScreenDuration,
          child: Image.asset(
            'assets/croix-agse/playstore.png',
            width: MediaQuery.of(context).size.shortestSide / 2,
          ),
        ),
      ),
    );
  }
}
