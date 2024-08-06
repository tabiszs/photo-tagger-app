import 'package:flutter/material.dart';
import 'package:photo_tagger/data/pages/add/add_photos_cubit.dart';
import 'package:provider/src/provider.dart';
import 'package:rive/rive.dart';

class SuccessResultPage extends StatelessWidget {
  const SuccessResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox.square(
                dimension: 120,
                child: RiveAnimation.asset('assets/rive/1029-2009-success-check.riv')),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => returnToNoPhotoPage(context),
              child: const Text('Wróć'),
            )
          ],
        ),
      ),
    );
  }

  void returnToNoPhotoPage(BuildContext context) {
    AddPhotosCubit cubit = context.read<AddPhotosCubit>();
    cubit.returntoNoPhotoPage();
  }
}
