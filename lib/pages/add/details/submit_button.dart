import 'package:flutter/material.dart';
import 'package:photo_tagger/data/messages.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.callback}) : super(key: key);
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: callback,
          child: Text(Msg.submit),
        ),
      ],
    );
  }
}
