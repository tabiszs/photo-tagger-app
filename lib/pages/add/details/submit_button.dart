import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/data/data.dart';
import 'package:provider/src/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.validationKey,
  }) : super(key: key);
  final GlobalKey<FormState> validationKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            if (validationKey.currentState!.validate()) {
              context.read<PhotoData>().state = PhotoState.completed;
              validationKey.currentState!.save();
              context.read<AddPhotosCubit>().showGridView();
            }
          },
          child: const Text("Zatwierdź"),
        ),
      ],
    );
  }
}
