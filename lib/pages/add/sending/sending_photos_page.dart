import 'package:flutter/material.dart';
import 'package:photo_tagger/data/messages.dart';

class SendingPhotosPage extends StatelessWidget {
  const SendingPhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Msg.sendingPhotos,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 15),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
