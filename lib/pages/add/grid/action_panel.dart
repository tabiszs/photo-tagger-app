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