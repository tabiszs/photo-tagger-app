import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_page.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return AddPhotosPage(user: user);
  }
}
