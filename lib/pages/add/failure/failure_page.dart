import 'package:flutter/material.dart';
import 'package:photo_tagger/data/messages.dart';
import 'package:photo_tagger/data/pages/add/add_photos_cubit.dart';
import 'package:provider/src/provider.dart';

class FailureResultPage extends StatelessWidget {
  const FailureResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Msg.tryAgain,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => returnToGridView(context),
              child: Text(Msg.returnText),
            )
          ],
        ),
      ),
    );
  }

  void returnToGridView(BuildContext context) {
    AddPhotosCubit cubit = context.read<AddPhotosCubit>();
    cubit.returnAddPhotosLoaded();
  }
}
