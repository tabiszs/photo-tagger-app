import 'package:flutter/material.dart';

class InitializePage extends StatelessWidget {
  const InitializePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InitializeWidget(),
    );
  }
}

class InitializeWidget extends StatelessWidget {
  const InitializeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/croix-agse/playstore.png',
          width: getImageDimension(context),
        ),
      ),
    );
  }

  double getImageDimension(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return width < height ? width / 2 : height / 2;
  }
}
