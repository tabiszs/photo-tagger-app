import 'package:flutter/material.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:provider/src/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.callback
  }) : super(key: key);
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: callback,
          child: const Text("Zatwierdź"),
        ),
      ],
    );
  }
}
