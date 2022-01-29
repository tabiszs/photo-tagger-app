import 'package:flutter/material.dart';
import 'package:photo_tagger/data/messages.dart';

class NoPhotoPage extends StatelessWidget {
  const NoPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Msg.addPhoto,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 40,
        ),
      ),
    );
  }
}
