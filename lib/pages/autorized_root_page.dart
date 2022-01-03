import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';
import 'package:provider/provider.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({
    Key? key,
    required this.signedInState,
  }) : super(key: key);

  final SignedInState signedInState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignedInState>(create: (_) => signedInState),
      ],
      child: const AddPhotosGate(),
    );
  }
}
