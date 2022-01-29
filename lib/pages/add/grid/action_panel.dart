import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/messages.dart';
import 'package:photo_tagger/data/pages/add/add_photos_cubit.dart';

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // onPressed: () => context.read<AddPhotosCubit>().addPhoto(),
      onPressed: () => BlocProvider.of<AddPhotosCubit>(context).addPhoto(),
      tooltip: Msg.add,
      child: const Icon(Icons.add),
    );
  }
}

class TagAndDelPhotoButtons extends StatelessWidget {
  const TagAndDelPhotoButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () => {
            //TODO - usuń zdjęcia wraz z tagami.
          },
          tooltip: Msg.remove,
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () => {
            //TODO - przejdź do formularza tagów
          },
          tooltip: Msg.edit,
          child: const Icon(Icons.label_outline),
        ),
      ],
    );
  }
}
