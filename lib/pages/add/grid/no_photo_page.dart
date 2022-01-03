import 'package:flutter/material.dart';

class NoPhotoPage extends StatelessWidget {
  const NoPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Dodaj zdjęcie',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 40,
        ),
      ),
    );
  }
}
