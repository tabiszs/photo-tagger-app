import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/add/action_panel.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/add_photos_scaffold.dart';
import 'package:photo_tagger/pages/add/failure_page.dart';
import 'package:photo_tagger/pages/add/no_photo_page.dart';
import 'package:photo_tagger/pages/add/add_photos_states.dart';
import 'package:photo_tagger/pages/add/grid_page.dart';
import 'package:photo_tagger/pages/add/ready_to_send_page.dart';
import 'package:photo_tagger/pages/add/sending_photos_page.dart';
import 'package:photo_tagger/pages/add/success_page.dart';

class AddPhotosGate extends StatelessWidget {
  const AddPhotosGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPhotosCubit, AddPhotosState>(
        builder: (context, state) {
      if (state is AddPhotosEmpty) {
        return const AddPhotosScaffold(
          bodyWidget: NoPhotoPage(),
          actionPanel: AddPhotoButton(),
        );
      } else if (state is AddPhotosLoaded) {
        return AddPhotosScaffold(
          bodyWidget: GridPage(paths: state.paths),
          actionPanel: const AddPhotoButton(),
        );
      } else if (state is AddPhotosReadyToSend) {
        return const ReadyToSendPage();
      } else if (state is AddPhotosSending) {
        return const SendingPhotosPage();
      } else if (state is AddPhotosSucces) {
        return const SuccessResultPage();
      } else if (state is AddPhotosFailure) {
        return const FailureResultPage();
      } else {
        throw Exception('Unknown add photos state');
      }
    });
  }
}
