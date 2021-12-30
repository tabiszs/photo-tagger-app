import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/allowed_photo_extention.dart';
import 'package:photo_tagger/pages/add/add_photos_states.dart';

class AddPhotosCubit extends Cubit<AddPhotosState> {
  AddPhotosCubit() : super(const AddPhotosEmpty()) {
    emit(const AddPhotosEmpty());
  }

  List<String> _paths = [];

  void addPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AllowedPhotoExtention.get(),
      allowMultiple: true,
    );

    if (result != null) {
      _paths.addAll(_addPaths((result.files)));
      emit(AddPhotosLoaded(paths: _paths));
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }

  List<String> _addPaths(List<PlatformFile> files) {
    List<String> newPaths = [];
    for (int i = 0; i < files.length; ++i) {
      newPaths.add(files[i].path!);
      print(files[i].name);
    }
    return newPaths;
  }
}
