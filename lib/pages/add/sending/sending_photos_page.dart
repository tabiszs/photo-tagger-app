import 'package:flutter/material.dart';

class SendingPhotosPage extends StatelessWidget {
  const SendingPhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: const Center(
        child: CircularProgressIndicator(),
        // Text(
        //       'Wysyłam zdjęcia z tagami.',
        //       style: Theme.of(context).textTheme.headline3,
        //     ),
      ),
    );
  }
}
