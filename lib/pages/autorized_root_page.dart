import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_page.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddPhotosPage();
  }
}
