import 'package:flutter/material.dart';

class InitializePage extends StatelessWidget {
  const InitializePage({required this.splashScreenDuration, Key? key}) : super(key: key);
  final Duration splashScreenDuration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColoredBox(
        color: Colors.white,
        child: Center(
          child: AnimatedOpacity(
            opacity: 1,
            duration: splashScreenDuration,
            child: Builder(builder: (ctx) {
              return Image.asset(
                'assets/croix-agse/playstore.png',
                width: MediaQuery.of(ctx).size.shortestSide / 2,
              );
            }),
          ),
        ),
      ),
    );
  }
}
