import 'package:flutter/material.dart';
import 'package:photo_tagger/data/photo/tag_info.dart';

enum PhotoState {
  unreplenished,
  touched,
  completed,
}

class PhotoData {
  final String path;
  PhotoState state;
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TagInfo tags;
  int index;

  PhotoData({
    required this.index,
    required this.path,
    required this.tags,
    this.state = PhotoState.unreplenished,
  });
}
