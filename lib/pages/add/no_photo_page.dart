import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/bar.dart';
import 'package:photo_tagger/pages/drawer.dart';
import 'package:provider/src/provider.dart';

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
