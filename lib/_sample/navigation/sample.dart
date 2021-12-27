import 'package:flutter/material.dart';

class MyNoRouteNavApp extends StatelessWidget {
  const MyNoRouteNavApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstNoRoutePage(),
    );
  }
}

class FirstNoRoutePage extends StatelessWidget {
  const FirstNoRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Container(
          color: Colors.red,
          child: const Text(
            'First Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const SecondNoRoutePage()));
        },
      ),
    );
  }
}

class SecondNoRoutePage extends StatelessWidget {
  const SecondNoRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Second Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
