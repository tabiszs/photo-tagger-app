import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/add_photos_states.dart';
import 'package:photo_tagger/pages/add/details/add_item_dialog.dart';
import 'package:photo_tagger/pages/add/details/tagger_form_page.dart';
import 'package:photo_tagger/pages/add/failure/failure_page.dart';
import 'package:photo_tagger/pages/add/ready_to_send_page.dart';
import 'package:photo_tagger/pages/add/sending/sending_photos_page.dart';
import 'package:photo_tagger/pages/add/success/success_page.dart';
import 'package:photo_tagger/pages/add/grid/action_panel.dart';
import 'package:photo_tagger/pages/common/app_view_scaffold.dart';
import 'package:photo_tagger/pages/add/grid/grid_page.dart';
import 'package:photo_tagger/pages/add/grid/no_photo_page.dart';
import 'package:photo_tagger/pages/add/grid/send_bar.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';
import 'package:photo_tagger/pages/common/bar.dart';
import 'package:provider/provider.dart';

class AddPhotosGate extends StatelessWidget {
  const AddPhotosGate({Key? key}) : super(key: key);
  static String title = 'Dodawanie zdjęć';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => context.read<SignedInState>().addPhotosCubit,
      child: BlocBuilder<AddPhotosCubit, AddPhotosState>(builder: (context, state) {
        if (state is AddPhotosEmpty) {
          return AppViewScaffold(
            bodyWidget: const NoPhotoPage(),
            actionPanel: const AddPhotoButton(),
            bar: MainBar(title: title),
          );
        } else if (state is AddPhotosLoaded) {
          return AppViewScaffold(
            bodyWidget: GridPage(datas: state.datas),
            actionPanel: const AddPhotoButton(),
            bar: SendBar(title: title),
          );
        } else if (state is AddPhotosReadyToSend) {
          return const ReadyToSendPage();
        } else if (state is AddPhotosSending) {
          return const SendingPhotosPage();
        } else if (state is AddPhotosSucces) {
          return const SuccessResultPage();
        } else if (state is AddPhotosFailure) {
          return const FailureResultPage();
        } else if (state is TaggingPageState) {
          return TaggerFormPage(data: state.data);
        } else if (state is AddTagState) {
          return AddItemDialog(
            dropDownListItems: state.dropDownListItems,
            data: state.data,
          );
        } else {
          throw Exception('Unknown add photos state');
        }
      }),
    );
  }
}
