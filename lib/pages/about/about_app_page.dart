import 'dart:io';

import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxPadding = MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('O Aplikacji'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: maxPadding,
          vertical: 10,
        ),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Image.asset('assets/images/icon-tagger.jpg'),
            const SizedBox(height: 30),
            const Text('Wersja 1.0.0'),
            const SizedBox(height: 10),
            const Text('Stanisław Tabisz'),
            const SizedBox(height: 10),
            const Text('stanislaw.tabisz@skauci-europy.pl'),
          ],
        ),
      ),
    );
  }
}
