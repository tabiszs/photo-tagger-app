import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPhotosCubit(),
      child: const AddPhotosGate(),
    );
  }
}
