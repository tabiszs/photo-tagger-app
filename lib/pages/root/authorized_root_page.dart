import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';
import 'package:provider/provider.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({
    required this.signedInState,
    Key? key,
  }) : super(key: key);

  final SignedInState signedInState;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => signedInState,
      child: const AddPhotosGate(),
    );
  }
}
