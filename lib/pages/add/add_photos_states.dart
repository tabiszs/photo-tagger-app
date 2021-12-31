import 'package:flutter/cupertino.dart';

abstract class AddPhotosState {
  const AddPhotosState();
}

class AddPhotosEmpty extends AddPhotosState {
  const AddPhotosEmpty();
}

class AddPhotosLoaded extends AddPhotosState {
  const AddPhotosLoaded({required this.paths});

  final List<String> paths;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    //bool result = o is AddPhotosLoaded && o.paths.length != paths.length;
    return false;
  }
}

class AddPhotosReadyToSend extends AddPhotosState {
  const AddPhotosReadyToSend();
}

class AddPhotosVerify extends AddPhotosState {
  const AddPhotosVerify();
}

class AddPhotosSending extends AddPhotosState {
  const AddPhotosSending();
}

class AddPhotosSucces extends AddPhotosState {
  const AddPhotosSucces();
}

class AddPhotosFailure extends AddPhotosState {
  const AddPhotosFailure();
}
