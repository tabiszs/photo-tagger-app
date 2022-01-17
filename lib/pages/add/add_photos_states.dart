import 'package:flutter/cupertino.dart';
import 'package:photo_tagger/pages/add/data.dart';

abstract class AddPhotosState {
  const AddPhotosState();
}

class AddPhotosEmpty extends AddPhotosState {
  const AddPhotosEmpty();
}

class AddPhotosLoaded extends AddPhotosState {
  const AddPhotosLoaded({required this.datas});

  final List<PhotoData> datas;

  @override
  bool operator ==(Object o) {
    return identical(this, o);
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

class TaggingPageState extends AddPhotosState {
  const TaggingPageState({required this.data});

  final PhotoData data;
}

class AddTagState extends AddPhotosState {
  const AddTagState({
    required this.data,
    required this.dropDownListItems,
  });

  final List<String>? dropDownListItems;
  final PhotoData data;
}
