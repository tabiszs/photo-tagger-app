import 'package:flutter/material.dart';
import 'package:photo_tagger/data/photo/tag_info.dart';

enum PhotoState {
  unreplenished,
  touched,
  completed,
}

class PhotoData with ChangeNotifier {
  PhotoState _state = PhotoState.unreplenished;
  final String path;
  final TagInfo tags;
  final int index;

  PhotoState get state => _state;
  set state(PhotoState state) {
    _state = state;
    notifyListeners();
  }

  PhotoData({
    required this.index,
    required this.path,
    required this.tags,
  });
}
