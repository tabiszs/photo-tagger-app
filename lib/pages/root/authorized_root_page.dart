import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
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
    return WillPopScope(
      onWillPop: () => logOut(context),
      child: Provider(
        create: (_) => signedInState,
        child: const AddPhotosGate(),
      ),
    );
  }

  Future<bool> logOut(BuildContext context) async {
    context.read<AuthCubit>().signOut;
    return true;
  }
}
