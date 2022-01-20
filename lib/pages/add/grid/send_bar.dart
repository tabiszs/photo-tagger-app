import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/common/bar.dart';
import 'package:provider/src/provider.dart';

class SendBar extends MainBar {
  const SendBar({Key? key, required String title}) : super(key: key, title: title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.send),
          tooltip: 'Prześlij zdjęcia',
          onPressed: () => validateAndSend(context),
        ),
      ],
    );
  }

  void validateAndSend(BuildContext context) {
    AddPhotosCubit cubit = context.read<AddPhotosCubit>();
    if (cubit.isAllCompleted()) {
      cubit.sendData();
    }
  }
}
