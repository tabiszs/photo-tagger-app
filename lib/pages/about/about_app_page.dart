import 'package:flutter/material.dart';
import 'package:photo_tagger/data/utils/photo_utils.dart';

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
        alignment: Alignment.center,
        child: ListView(
          children: [
            const SizedBox(height: 30),
            SizedBox.square(
              dimension: PhotoUtils.size,
              child: Image.asset('assets/images/badges.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 30),
                Text('Wersja 0.1.0'),
                SizedBox(height: 10),
                Text('Stanisław Tabisz'),
                SizedBox(height: 10),
                Text('stanislaw.tabisz@skauci-europy.pl'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
